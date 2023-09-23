local ls = require("luasnip")
local s = ls.snippet
local c = ls.choice_node
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local t = ls.text_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
-- local rep = require("luasnip.extras").rep

ls.add_snippets("sh", {
    s("if", {
        t"if ",
        c(1, {
            i(1, "condition"),
            sn(nil, {
                t"[[ ",
                i(1, "condition"),
                t" ]]",
            })
        }),
        t{"; then", "\t"},
        c(2, {
            i(1),
            sn(nil, fmt([[
            {body1}
            else
                {body2}
            ]], {
                body1 = i(1),
                body2 = i(2)
            }))
        }),
        t{"", "fi"}
    }),

    s({trig = ".*eif", regTrig = true}, {
        t"elif ",
        c(1, {
            i(1, "condition"),
            sn(nil, {
                t" [[",
                i(1, "condition"),
                t" ]]"
            })
        }),
        t({"; then", "\t"}),
        i(2)
    }),

    s("fn", fmt([[
    function {name}() {{
        {body}
    }}
    ]], {
        name = i(1, "name"),
        body = i(0)
    })),

    s("alias", fmt([[
    alias {name}="{content}"
    ]], {
        name = i(1, "name"),
        content = i(0)
    })),

    s("for", fmt([[
    for {var} in {condition}; do
        {body}
    done
    ]], {
        var = i(1, "i"),
        condition = c(2, {
            i(1,"list"),
            sn(nil, fmt([[$(seq {} {})]], {
                i(1, "start"),
                i(2, "inclusive")
            }))
        }),
        body = i(0)
    })),

    s("var", fmt([[{name}={choice}]], {
        name = c(1, {
            r(1, "varname"),
            sn(nil, {
                t"local ",
                r(1, "varname")
            })
        }),
        choice = c(2, {
            sn(nil, {
                t"$(",
                r(1, "varvalue"),
                t")"
            }),
            sn(nil, {
                t[["]],
                r(1, "varvalue"),
                t[["]],
            })
        })
    }), {
        stored = {
            ["varname"] = i(1, "name"),
            ["varvalue"] = i(1, "value"),
        },
    })
})
