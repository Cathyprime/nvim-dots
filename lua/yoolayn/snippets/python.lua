local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
-- local l = extras.lambda
local rep = extras.rep
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
local k = require("luasnip.nodes.key_indexer").new_key

local function testCase(classname, snip)
    local retTable = {}
    for index=2,snip.captures[1] do
        local snippet = sn(index - 1, fmt([[
        def test_{cls}_{propRep}(self) -> None:
            {obj} = {cls}({args})
            self.assertEqual({val}, {obj}.{prop})
        ]], {
            cls = t(classname),
            prop = i(1, "property"),
            obj = f(function(args)
                local arg_str = args[1][1]:gsub(', ', ',')
                return arg_str
            end, { k("objname") }),
            args = f(function(args)
                return args[1][1] or "\"haiii :3\""
            end, { k("arguments") }),
            val = f(function(args)
                local args_str = args[1][1]:gsub(', ', ',')
                if args_str == "" then
                    return "\"haiii :3\""
                end
                local args_split = vim.split(args_str, ',')
                return args_split[index] or "\"haaaiii :3\""
            end, { k("arguments") }),
            propRep = rep(1),
        }))
        table.insert(retTable, t({"", "", ""}))
        table.insert(retTable, snippet)
    end
    return retTable
end

return {

    s(
        {trig = "testdata([%d]+)", regTrig = true},
        fmt([[
        class Test{classname}(unittest.TestCase):

            def test_{cls}_{propRep}(self) -> None:
                {obj} = {cls}({args})
                self.assertEqual({val}, {objRep}.{prop}){arms}
        ]],
            {
                classname = i(1, "ClassName"),
                cls = rep(1),
                args = i(3, "args", { key = "arguments" }),
                prop = i(4, "property"),
                propRep = rep(4),
                val = f(function(args)
                    local args_str = args[1][1]:gsub(", ", ",")
                    if args_str == "" then
                        return "\"haiii :3\""
                    end
                    local args_split = vim.split(args_str, ',')
                    return args_split[1] or "\"haaaiii :3\""
                end, { k("arguments") }),
                obj = i(2, "val", { key = "objname" }),
                objRep = rep(2),
                arms = d(5, function(cls, snip)
                     local tab = testCase(cls[1][1] or ":3", snip)
                     return isn(1, tab or t("empty :c"), "$PARENT_INDENT\t")
                end, { 1 })
            }
        )
    ),

    s("test", fmt([[
    def test_{name}(self{args}) -> None:
        {body}
    ]], {
        name = i(1, "name"),
        args = i(2),
        body = i(0)
    })),

    s("prop", fmt([[
    @property
    def {name}(self) -> {type}:
        return self._{repName1}

    @{repName2}.setter
    def {repName3}(self, value: {repType}) -> None:
        self._{repName4} = value
    ]], {
        name = i(1, "name"),
        repName1 = rep(1),
        repName2 = rep(1),
        repName3 = rep(1),
        repName4 = rep(1),
        type = i(2, "type"),
        repType = rep(2),
    })),

    s("unittest", fmt([[
    import unittest
    from {module} import {import}


    {body}


    if __name__ == '__main__':
        unittest.main()
    ]], {
        body = i(0),
        module = i(1, "module"),
        import = i(2, "stuff")
    })),

    s("fn", fmt([[
    def {name}({args}) -> {type}:
        {body}
    ]], {
        name = i(1, "name"),
        args = i(2),
        type = i(3, "RetType"),
        body = i(0)
    })),

    s("m", fmt([[
    def {name}(self{args}) -> {type}:
        {body}
    ]], {
        name = i(1, "name"),
        args = i(2),
        type = i(3, "RetType"),
        body = i(0)
    })),

    s("p", fmt([[print({})]], {
        i(0),
    })),

    s("if", fmt([[
    if {cond}:
        {body}
    ]],{
        cond = i(1, "condition"),
        body = c(2, {
            i(1),
            isn(nil, fmt([[
            {body1}
            else:
                {body2}
            ]], {
                body1 = i(1),
                body2 = i(2)
            }), "$PARENT_INDENT")
        })
    })),

    s({trig = [[\%( \{4\}\| \)\?eif]], hidden = true, regTrig = true, trigEngine = "vim"}, fmt([[
    elif {cond}:
        {body}
    ]], {
        cond = i(1, "condition"),
        body = i(2)
    })),

    s("class", fmt([[
    class {name}{inheritance}:

        {body}
    ]], {
        name = i(1, "name"),
        inheritance = c(2, {
            t"",
            sn(nil, {
                t"(",
                i(1, "class"),
                t")"
            })
        }),
        body = i(0)
    })),

    s("init", fmt([[
    def __init__(self{args}) -> None:
        {assign}{body}
    ]], {
        args = i(1),
        assign = d(2, function (args)
            local args_str = args[1][1]
            args_str = args_str:gsub(', ', ',')
            args_str = args_str:sub(2) or ""
            if args_str == "" then
                return sn(nil, {t("")})
            end
            local args_split = vim.split(args_str, ',')
            local nodes = {}

            for _, arg in ipairs(args_split) do
                local trimmed = vim.split(arg, "=")[1] or arg
                local name = vim.split(trimmed, ":")[1] or ""
                local type = vim.split(trimmed, ":")[2] or ""
                if type ~= "" then
                    type = ": " .. type
                end
                table.insert(nodes, "self." .. name .. type .. " = " .. name)
            end
            return isn(nil, t(nodes), "$PARENT_INDENT\t")
        end, { 1 }),
        body = i(0)
    })),

}
