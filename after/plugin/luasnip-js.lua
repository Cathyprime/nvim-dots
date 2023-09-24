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
local rep = require("luasnip.extras").rep

ls.add_snippets("javascript", {
    s("fn", fmt([[
    {fn} {{
        {body}
    }}
    ]], {
        fn = c(1, {
            sn(nil, {
                c(1, {
                    t"const ",
                    t"let ",
                }),
                i(2, "name"),
                t" = (",
                i(3),
                t") =>",
            }),
            sn(nil, {
                t"function ",
                i(1, "name"),
                t" (",
                i(2),
                t")"
            }),
            sn(nil, {
                c(1, {
                    t"const ",
                    t"let ",
                }),
                i(2, "name"),
                t" = function (",
                i(3),
                t")"
            }),
        }),
        body = i(0)
    })),

    s("p", fmt([[
    console.log({val});
    ]], {
        val = i(0)
    })),

    s("var", fmt([[
    {type} {name}{value};
    ]], {
        type = c(1, {
            t"let",
            t"const",
        }),
        name = i(2, "name"),
        value = c(3, {
            sn(nil, {
                t" = ",
                i(1, "value")
            }),
            t"",
        })
    })),

    s("()", fmt([[
    ({}) => {{{}}}
    ]], {
        i(1),
        i(0)
    })),

    s("reduce", fmt([[
    {var}{array}.reduce({fn}{initVal})
    ]], {
        var = c(1, {
            sn(nil, {
                c(1, {
                    t"const ",
                    t"let ",
                }),
                i(2, "name"),
                t" = "
            }),
            t""
        }),
        array = i(2, "array"),
        fn = c(4, {
            t"",
            sn(nil, {
                t"(",
                i(1, "acc"),
                t", ",
                i(2, "elem"),
                t(") => {"),
                i(3),
                t"}"
            })
        }),
        initVal = c(3, {
            sn(nil, {
                t", ",
                i(1, "initialValue")
            }),
            t""
        })
    })),

    s("if", fmt([[
    if ({cond}) {{
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

    s({trig = ".*eif", regTrig = true, hidden = true}, fmt([[
    }} else if ({condition}) {{
        {body}
    ]], {
        condition = i(1),
        body = i(0),
    })),

    s("req", fmt([[
    const {name} = require("{module}");
    ]], {
        name = f(function (import_name)
            local parts = vim.split(import_name[1][1], "%/")
            if parts[#parts] == "lodash" then
                return "_"
            else
                return parts[#parts] or "name"
            end
        end, { 1 }),
        module = i(1, "module")
    })),

    s("class", fmt([[
    class {name} {{
        {body}
    }}
    ]], {
        name = i(1, "className"),
        body = i(0)
    })),

    s("init", fmt([[
    constructor({args}) {{
        {assign}{body}
    }}
    ]], {
        args = i(1),
        assign = d(2, function (args)
            local args_str = args[1][1]
            args_str = args_str:gsub(' ', '')
            if args_str == "" then
                return sn(nil, {t("")})
            end
            local args_split = vim.split(args_str, ',')
            local nodes = {}

            for _, arg in ipairs(args_split) do
                table.insert(nodes, "this." .. arg .. " = " .. arg .. ";")
            end
            return isn(nil, t(nodes), "$PARENT_INDENT\t")
        end, { 1 }),
        body = i(0)
    })),

    s("m", fmt([[
    {name}({args}) {{
        {body}
    }}
    ]], {
        name = i(1, "function name"),
        args = i(2),
        body = i(0)
    })),

    s("t", fmt([[
    this.{name}{val}
    ]], {
        name = i(1, "name"),
        val = c(2, {
            t"",
            sn(nil, {
                t" = ",
                i(1, "value"),
                t";"
            })
        }),
    }))
})
