local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
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

return {
    s("fn", fmt([[
    fn {funame}({arg}) -> {retype} {{
        {body}
    }}
    ]], {
        funame = i(1, "name"),
        arg = i(2, "arg"),
        retype = i(3, "RetType"),
        body = i(0, "unimplemented!();")
    })),

    s("p", fmt([[println!({});]], {i(0)})),

    s("main", fmt([[
    fn main() {}{{
        {}
    }}
    ]], {
        c(1, {
            t"",
            sn(nil, {t"-> ", i(1, "RetType"), t" "})
        }),
        i(0, "unimplemented!()"),
    })),

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

    s(
        { trig = "match([%a]+)([%d]+)", regTrig = true, hidden = true },
        fmt([[
        {assign}match {var} {{
            {arms}
        }}
        ]], {
            assign = c(1, {
                sn(nil, {t("let "), i(1, "name"), t(": "), i(2, "type"), t(" = ")}),
                t""
            }),
            var = i(2, "variable"),
            arms = d(3, function (_, snip)
                local retTable = {}
                local function new_line(index)
                    if index == 1 then
                        return t("")
                    else
                        return t({"", ""})
                    end
                end
                for index=1,snip.captures[2] do
                    table.insert(retTable, isn(index, {
                        new_line(index),
                        t(snip.captures[1] .. "::"),
                        i(1),
                        t(" => "),
                        c(2, {
                            sn(nil, i(1)),
                            sn(nil, {t"{", i(1), t"}"})
                        }),
                        t(",")
                    }, "$PARENT_INDENT\t"))
                end
                return sn(nil, retTable)
            end)
        })
    ),

    s(
        { trig = "match([%d]+)", regTrig = true, hidden = true },
        fmt([[
        {assign}match {var} {{
            {arms}
        }}
        ]], {
            assign = c(1, {
                sn(nil, {t("let "), i(1, "name"), t(": "), i(2, "type"), t(" = ")}),
                t""
            }),
            var = i(2, "variable"),
            arms = d(3, function (_, snip)
                local retTable = {};
                local function new_line(index)
                    if index == 1 then
                        return t("")
                    else
                        return t({"", ""})
                    end
                end
                for index=1,snip.captures[1] do
                    table.insert(retTable, isn(index, {
                        new_line(index),
                        i(1, "pattern"),
                        t(" => "),
                        c(2, {
                            sn(nil, i(1)),
                            sn(nil, {t"{", i(1), t"}"})
                        }),
                        t(",")
                    }, "$PARENT_INDENT\t"))
                end
                return sn(nil, retTable)
            end)
        })
    ),

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
    }))

}
