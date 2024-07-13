local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local tsp = require("luasnip.extras.treesitter_postfix")
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local extras = require("luasnip.extras")
-- local l = extras.lambda
-- local rep = extras.rep
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local conds = require("luasnip.extras.expand_conditions")
-- local postfix = require("luasnip.extras.postfix").postfix
-- local types = require("luasnip.util.types")
-- local parse = require("luasnip.util.parser").parse_snippet
-- local ms = ls.multi_snippet
-- local k = require("luasnip.nodes.key_indexer").new_key

local expr_query = [[
[
    (struct_expression)
    (call_expression)
    (identifier)
    (field_expression)
    (integer_literal)
    (string_literal)
] @prefix
]]

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

local function result_ok_type_callback(match)
    return replace_all(match, "Result<%s, _>")
end

local function result_err_type_callback(match)
    return replace_all(match, "Result<_, %s>")
end

local function build_simple_replace_callback(replaced)
    return function(match)
        return replace_all(match, replaced)
    end
end

local expr_node_types = {
    ["struct_expression"] = true,
    ["call_expression"] = true,
    ["identifier"] = true,
    ["field_expression"] = true,
    ["integer_literal"] = true,
    ["string_literal"] = true,
}

local expr_or_type_query = [[
[
    (struct_expression)
    (call_expression)
    (identifier)
    (field_expression)
    (integer_literal)
    (string_literal)

    (type_identifier)
    (generic_type)
    (scoped_type_identifier)
    (reference_type)
] @prefix
]]

local function expr_or_type_tsp(trig, typename, expr_callback, type_callback)
    local name = ("(%s) %s"):format(trig, typename)
    local dscr = ("Wrap expression/type with %s"):format(typename)
    return tsp.treesitter_postfix({
        trig = trig,
        name = name,
        dscr = dscr,
        wordTrig = false,
        reparseBuffer = "live",
        matchTSNode = {
            query = expr_or_type_query,
            query_lang = "rust",
        },
    }, {
        f(function(_, parent)
            local env = parent.snippet.env
            local data = env.LS_TSDATA
            if expr_node_types[data.prefix.type] then
                return expr_callback(env.LS_TSMATCH)
            else
                return type_callback(env.LS_TSMATCH)
            end
        end),
    })
end

local function new_expr_or_type_tsp(trig, typename)
    local expr_callback = function(match)
        return replace_all(match, typename .. "::new(%s)")
    end
    local type_callback = function(match)
        return replace_all(match, typename .. "<%s>")
    end
    return expr_or_type_tsp(trig, typename, expr_callback, type_callback)
end

local function both_replace_expr_or_type_tsp(trig, pattern)
    local template = pattern:gsub("?", "%%s")
    return expr_or_type_tsp(
        trig,
        pattern,
        build_simple_replace_callback(template),
        build_simple_replace_callback(template)
    )
end

return {
    new_expr_or_type_tsp(".rc", "Rc"),
    new_expr_or_type_tsp(".arc", "Arc"),
    new_expr_or_type_tsp(".box", "Box"),
    new_expr_or_type_tsp(".mu", "Mutex"),
    new_expr_or_type_tsp(".rw", "RwLock"),
    new_expr_or_type_tsp(".cell", "Cell"),
    new_expr_or_type_tsp(".refcell", "RefCell"),
    both_replace_expr_or_type_tsp(".ref", "&?"),
    both_replace_expr_or_type_tsp(".refm", "&mut ?"),
    both_replace_expr_or_type_tsp(".vec", "Vec<?>"),

    s("fn", fmt([[
    fn {funame}({arg}){arrow}{retype} {{
        {body}
    }}
    ]], {
        funame = i(1, "name"),
        arg = i(2),
        retype = i(3),
        arrow = f(function(args)
            if args and args[1] and args[1][1] ~= "" then
                return " -> "
            else
                return ""
            end
        end, { 3 }),
        body = i(0, "unimplemented!();")
    })),

    s("test", fmt([[
    #[test]
    fn {funame}() {{
        {body}
    }}
    ]], {
        funame = i(1, "name"),
        body = i(0, "unimplemented!();")
    })),

    s("p", fmt([[println!({});]], {i(0)})),

    s("var", fmt([[let {mut}{name}: {type} = {value};]], {
        mut = c(1, {t "", t "mut "}),
        name = i(2, "name"),
        type = i(3, "type"),
        value = i(0, "value")
    })),

    s("for", fmt([[
    for {var} in {table} {{
        {body}
    }}
    ]], {
        var = i(1, "variable"),
        table = i(2, "x..y"),
        body = i(0)
    })),

    s("while", fmt([[
    while {condition} {{
        {body}
    }}
    ]], {
        condition = i(1, "true"),
        body = i(0)
    })),

    s("whilet", fmt([[
    while let {pattern} = {expression} {{
        {body}
    }}
    ]], {
        pattern = i(1, "pattern"),
        expression = i(2, "expression"),
        body = i(0)
    })),

    s("enum", fmt([[
    enum {name} {{
        {body}
    }}
    ]], {
        name = i(1, "name"),
        body = i(0)
    })),

    s("struct", fmt([[
    struct {name} {{
        {body}
    }}
    ]], {
        name = i(1, "name"),
        body = i(0)
    })),

    s("if", fmt([[
    if {cond} {{
        {body}
    }}
    ]],{
        cond = i(1, "condition"),
        body = c(2, {
            sn(nil, fmt("   {}", {
                i(1)
            })),
            sn(nil, fmt([[
        {body1}
        }} else {{
            {body2}
        ]], {
                body1 = i(1),
                body2 = i(2)
            }))
        })
    })),

    s({trig = [[\%( \{4\}\| \)\?eif]], hidden = true, regTrig = true, trigEngine = "vim"}, fmt([[
    }} else if {condition} {{
        {body}
    ]], {
        condition = i(1),
        body = i(0),
    })),

    expr_or_type_tsp(
        ".ok",
        "Ok(?)",
        build_simple_replace_callback("Ok(%s)"),
        result_ok_type_callback
    ),
    expr_or_type_tsp(
        ".err",
        "Err(?)",
        build_simple_replace_callback("Err(%s)"),
        result_err_type_callback
    ),
    expr_or_type_tsp(
        ".some",
        "Some(?)",
        build_simple_replace_callback("Some(%s)"),
        build_simple_replace_callback("Option<%s>")
    ),

    tsp.treesitter_postfix({
        trig = ".println",
        name = [[(.println) println!("{:?}", ?)]],
        dscr = [[Wrap expression with println!("{:?}", ?)]],
        wordTrig = false,
        reparseBuffer = "live",
        matchTSNode = {
            query = expr_query,
            query_lang = "rust",
        },
    }, {
        f(function(_, parent)
            return replace_all(
                parent.snippet.env.LS_TSMATCH,
                [[println!("{:?}", %s)]]
            )
        end, {}),
    }),

}
