local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local f = ls.function_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local extras = require("luasnip.extras")
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local tsp = require("luasnip.extras.treesitter_postfix").treesitter_postfix

local function ranges_views_snippet(trig, func)
    return s(trig,
        fmta([[
		| <namespace>::views::<fn>([&](auto&& value) {
			<body>
		})
      ]], {
        namespace = c(1, {
            t("ranges"),
            t("std"),
        }),
        body = i(0),
        fn = func,
    })
    )
end

local function replace_all(match, template)
    match = vim.F.if_nil(match, "")
    ---@type string
    local match_str = ""
    if type(match) == "table" then
        match_str = table.concat(match, "\n")
    else
        match_str = match
    end

    local ret = template:gsub("%%s", match_str)
    local ret_lines = vim.split(ret, "\n", {
        trimempty = false,
    })

    return ret_lines
end

local function type_snippet(short, long)
    return s({ trig = short, snippetType = "autosnippet" }, t(long))
end

local default_quick_markers = {
    v = { params = 1, template = "std::vector<%s>" },
    a = { params = 1, template = "std::array<%s>" },
    q = { params = 1, template = "std::unique_ptr<%s>" },
    p = { params = 1, template = "std::shared_ptr<%s>" },
    c = { params = 0, template = "Placeholder" },
    i = { params = 0, template = "int32_t" },
    s = { params = 0, template = "std::string" },
    u = { params = 0, template = "uint32_t" },
    m = { params = 2, template = "absl::flat_hash_map<%s, %s>" },
    t = { params = -1, template = "std::tuple<%s>" },
}

local function quick_type(shortcut)
    local markers = vim.deepcopy(default_quick_markers)

    ---@param s string
    ---@return string?, string?
    local function expect_typename(s)
        local first, rest = s:match("^(%l)(.*)$")
        if first == nil then
            return nil, nil
        end

        local trig = markers[first]
        if trig == nil then
            return nil, nil
        end

        if trig.params == -1 then
            local parameters = {}
            while #rest > 0 do
                local typename, sub_rest = expect_typename(rest)
                if typename == nil or sub_rest == nil then
                    break
                end
                parameters[#parameters + 1] = typename
                rest = sub_rest
            end
            return (trig.template):format(table.concat(parameters, ", ")), rest
        end

        if trig.params == 0 then
            local template = trig.template
            if trig.template == "Placeholder" then
                template = vim.fn.input({
                    prompt = "Custom: ",
                    default = "Placeholder",
                    cancelreturn = "Placeholder"
                })
            end

            return template, rest
        end

        local parameters = {}
        for _ = 1, trig.params do
            local typename, sub_rest = expect_typename(rest)
            if typename == nil or sub_rest == nil then
                return nil, rest
            end
            parameters[#parameters + 1] = typename
            rest = sub_rest
        end

        return string.format(trig.template, unpack(parameters)), rest
    end

    local result, rest = expect_typename(shortcut)
    if rest and #rest > 0 then
        print(("After QET eval, rest not empty: %s"):format(rest))
    end
    if result == nil then
        return shortcut
    else
        return result
    end
end

local function make_type_matcher(types)
    if type(types) == "string" then
        return { [types] = 1 }
    end

    if type(types) == "table" then
        if vim.islist(types) then
            local new_types = {}
            for _, v in ipairs(types) do
                new_types[v] = 1
            end
            return new_types
        end
    end

    return types
end

local function find_first_parent(node, types)
    local matcher = make_type_matcher(types)

    ---@param root TSNode|nil
    ---@return TSNode|nil
    local function find_parent_impl(root)
        if root == nil then
            return nil
        end
        if matcher[root:type()] == 1 then
            return root
        end
        return find_parent_impl(root:parent())
    end

    return find_parent_impl(node)
end

local function invoke_after_reparse_buffer(ori_bufnr, match, fun)
    local function reparse_buffer()
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        local lines = vim.api.nvim_buf_get_lines(ori_bufnr, 0, -1, false)
        local current_line = lines[row]
        local current_line_left = current_line:sub(1, col - #match)
        local current_line_right = current_line:sub(col + 1)
        lines[row] = current_line_left .. current_line_right
        local lang = vim.treesitter.language.get_lang(vim.bo[ori_bufnr].filetype) or vim.bo[ori_bufnr].filetype

        local source = table.concat(lines, "\n")
        ---@type vim.treesitter.LanguageTree
        local parser = vim.treesitter.get_string_parser(source, lang)
        parser:parse(true)

        return parser, source
    end

    local parser, source = reparse_buffer()

    local ret = { fun(parser, source) }

    parser:destroy()

    return unpack(ret)
end

local function inject_class_name(_, line_to_cursor, match, captures)
    -- check if at the line begin
    if not line_to_cursor:sub(1, -(#match + 1)):match("^%s*$") then
        return nil
    end

    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local buf = vim.api.nvim_get_current_buf()

    return invoke_after_reparse_buffer(buf, match, function(parser, source)
        local pos = {
            row - 1,
            col - #match, -- match has been removed from source
        }
        local node = parser:named_node_for_range({
            pos[1],
            pos[2],
            pos[1],
            pos[2],
        })
        if node == nil then
            return nil
        end

        local class_node = find_first_parent(node, {
            "struct_specifier",
            "class_specifier",
        })
        if class_node == nil then
            return nil
        end
        local name_nodes = class_node:field("name")
        if name_nodes == nil or #name_nodes == 0 then
            return nil
        end
        local name_node = name_nodes[1]
        local ret = {
            trigger = match,
            captures = captures,
            env_override = {
                CLASS_NAME = vim.treesitter.get_node_text(name_node, source),
            },
        }
        return ret
    end)
end

local function constructor_snip(trig, name, template)
    return ls.s(
        {
            trig = trig,
            name = ("(%s) %s"):format(trig, name),
            wordTrig = true,
            trigEngine = "plain",
            hidden = true,
            resolveExpandParams = inject_class_name,
        },
        d(1, function(_, parent)
            local env = parent.env
            return sn(
                nil,
                fmta(template, {
                    cls = t(env.CLASS_NAME),
                })
            )
        end)
    )
end

local nodes = {
    query = [[
              [
                (call_expression)
                (identifier)
                (type_identifier)
                (template_function)
                (subscript_expression)
                (field_expression)
                (user_defined_literal)
              ] @prefix
            ]],
    query_lang = "cpp",
}

local type_query = [[
[
  (type_identifier)
] @prefix
]]

local function type(trig, replacement)
    return tsp({
        trig = trig,
        wordTrig = false,
        reparseBuffer = "live",
        snippetType = "autosnippet",
        matchTSNode = {
            query = type_query,
            query_lang = nodes.query_lang,
        },
    }, {
        f(function(_, parent)
            return replace_all(parent.snippet.env.LS_TSMATCH, replacement)
        end, {}),
    })
end

return {
    type(".uniq", "std::unique_ptr<%s>"),
    type(".opt", "std::optional<%s>"),
    type(".sh", "std::shared_ptr<%s>"),

    ranges_views_snippet("|trans", t("transform")),
    ranges_views_snippet("|filter", t("filter")),
    ranges_views_snippet("|c", i(2, "func")),

    type_snippet("u8", "uint8_t"),
    type_snippet("u16", "uint16_t"),
    type_snippet("u32", "uint32_t"),
    type_snippet("u64", "uint64_t"),

    type_snippet("i8", "int8_t"),
    type_snippet("i16", "int16_t"),
    type_snippet("i32", "int32_t"),
    type_snippet("i64", "int64_t"),

    s({
        trig = "t(%l+)!",
        wordTrig = true,
        regTrig = true,
        snippetType = "autosnippet",
        name = "(t) Quick types",
        desc = "Expands to a type",
    }, {
        f(function(_, snip)
            local shortcut = snip.captures[1]
            return quick_type(shortcut)
        end),
    }),

    s({ trig = "#o", snippetType = "autosnippet" }, { t("#pragma once") }),

    s({ trig = '#"', snippetType = "autosnippet" }, fmt([[
    #include "{file}"
    ]],
        { file = i(1, "file"), }
    )),

    s({ trig = "#<", snippetType = "autosnippet" }, fmt([[
    #include <{file}>
    ]],
        { file = i(1, "file"), }
    )),

    tsp({
        trig = ".mv",
        matchTSNode = nodes,
    }, {
        f(function(_, parent)
            local node_content = table.concat(parent.snippet.env.LS_TSMATCH, "\n")
            local replaced_content = ("std::move(%s)"):format(node_content)
            return vim.split(replaced_content, "\n", { trimempty = false })
        end),
    }),

    tsp({
        trig = ".be",
        matchTSNode = nodes,
    }, {
        f(function(_, parent)
            local node_content = table.concat(parent.snippet.env.LS_TSMATCH, "\n")
            local replaced_content = ("%s.begin(), %s.end()"):format(node_content, node_content)
            return vim.split(replaced_content, "\n", { trimempty = false })
        end),
    }),

    tsp({
        trig = ".sizeof",
        matchTSNode = nodes,
    }, {
        f(function(_, parent)
            local node_content = table.concat(parent.snippet.env.LS_TSMATCH, "\n")
            local replaced_content = ("sizeof(%s) / sizeof(%s[0])"):format(node_content, node_content)
            return vim.split(replaced_content, "\n", { trimempty = false })
        end),
    }),

    tsp({
        trig = ".sc",
        snippetType = "autosnippet",
        matchTSNode = nodes,
    }, fmt([[static_cast<{}>({}){}]], {
        i(1, "type"),
        f(function(_, parent)
            local node_content = table.concat(parent.snippet.env.LS_TSMATCH, "\n")
            return vim.split(node_content, "\n", { trimempty = false })
        end),
        i(0),
    })),

    tsp({
        trig = ".uu",
        snippetType = "autosnippet",
        matchTSNode = nodes,
    }, {
        f(function(_, parent)
            local node_content = table.concat(parent.snippet.env.LS_TSMATCH, "\n")
            local replaced_content = ("(void)%s"):format(node_content)
            return vim.split(replaced_content, "\n", { trimempty = false })
        end),
    }),

    constructor_snip(
        "ctor",
        "Default constructor",
        [[
        <cls>() = default;
        ]]
    ),
    constructor_snip(
        "dtor",
        "Default destructor",
        [[
        ~<cls>() = default;
        ]]
    ),
    constructor_snip(
        "cc",
        "Copy constructor",
        [[
        <cls>(const <cls>& rhs) = default;
        ]]
    ),
    constructor_snip(
        "ca",
        "Copy assigment",
        [[
        <cls>& operator=(const <cls>& rhs) = default;
        ]]
    ),
    constructor_snip(
        "mv",
        "Move constructor",
        [[
        <cls>(<cls>&& rhs) = default;
        ]]
    ),
    constructor_snip(
        "ncc",
        "No copy constructor",
        [[
        <cls>(const <cls>&) = delete;
        ]]
    ),
    constructor_snip(
        "nmv",
        "No move constructor",
        [[
        <cls>(<cls>&&) = delete;
        ]]
    ),
    constructor_snip(
        "ncm",
        "No copy and move constructor",
        [[
        <cls>(const <cls>&) = delete;
        <cls>(<cls>&&) = delete;
        ]]
    ),
}
