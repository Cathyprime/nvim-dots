local ls = require("luasnip")
local s = ls.snippet
local c = ls.choice_node
local sn = ls.snippet_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
-- local rep = require("luasnip.extras").rep

ls.add_snippets("lua", {
    s("req", fmt([[local {varname} = require "{path}"]], {
        varname = f(function(import_name)
            local parts = vim.split(import_name[1][1], "%.")
            return parts[#parts] or ""
        end, {1}),
        path = i(1)
    })),

    s("reqc", fmt([[require("{}").{}({})]], {
        i(1, "module"),
        i(2, "setup"),
        i(0)
    })),

    s(
        {trig = "(.*)fn", regTrig = true},
        fmt([[{}]], {
            d(1, function(_, snip)
                if snip.captures[1] == "" then
                    return sn(nil, fmt([[
                        {scope}function {name}({args})
                            {body}
                        end
                        ]], {
                            scope = c(1, {t("local "), t("")}),
                            name = i(2, "name"),
                            args = i(3),
                            body = i(4, "???")
                        }))
                else
                    return sn(nil, fmt([[
                        {before}function ({args})
                            {body}
                        end
                        ]], {
                            before = t(snip.captures[1]),
                            args = i(1),
                            body = i(2, "???")
                        }))
                end
            end)
            })
        ),

    s("setup", fmt("setup({{{}}})", {
        i(0)
    })),

    s("var", fmt("local {} = {}", {
        i(1, "name"),
        i(0, "value")
    })),

    s("p", fmt([[print({})]], {
        i(0),
    })),

    s("noti", fmt([[vim.notify("{}", {}, {{{}}})]], {
        i(1, "message"),
        i(2, "loglevel"),
        i(3, "")
    })),

    s("for", fmt([[
    for {index}, {value} in {pair}({table}) do
        {body}
    end
    ]], {
        pair = c(1, {
            t("pairs"),
            t("ipairs")
        }),
        index = i(2, "_"),
        value = i(3, "v"),
        table = i(4),
        body = i(5)
    })),

    s("while", fmt([[
    while {cond} do
        {body}
    end
    ]],{
        cond = i(1, "condition"),
        body = i(2)
    })),

    s("mod", fmt([[
    local M = {{}}

    {body}

    return M
    ]], {
        body = i(0)
    })),

    s("meth", fmt([[
    local M.{name} = function({args})
        {body}
    end
    ]], {
        name = i(1, "name"),
        args = i(2),
        body = i(3),
    })),

    s("if", fmt([[
    if {cond} then
        {body}
    end
    ]],{
        cond = i(1, "condition"),
        body = c(2, {
            sn(nil, fmt("   {}", {
                i(1)
            })),
            sn(nil, fmt([[
            {body1}
            else
                {body2}
            ]], {
                body1 = i(1),
                body2 = i(2)
            }))
        })
    })),

    s("elseif", fmt([[
    elseif {cond} then
        {body}
    ]], {
        cond = i(1, "condition"),
        body = i(2)
    })),

})
