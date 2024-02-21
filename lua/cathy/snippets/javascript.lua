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
local ai = require("luasnip.nodes.absolute_indexer")
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
-- local k = require("luasnip.nodes.key_indexer").new_key

return {
    s("timeout", fmt([[
    setTimeout(({args}) => {{
        {body}
    }}, {time})
    ]], {
        args = i(1),
        time = i(2, "time"),
        body = i(0)
    })),

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
                t"(",
                i(2),
                t")"
            }),
            sn(nil, {
                c(1, {
                    t"const ",
                    t"let ",
                }),
                i(2, "name"),
                t" = function(",
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
            t"const",
            t"let",
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

    s({trig = [[\%( \{4\}\| \)\?eif]], hidden = true, regTrig = true, trigEngine = "vim"}, fmt([[
    }} else if ({condition}) {{
        {body}
    ]], {
        condition = i(1),
        body = i(0),
    })),

    s("imp", fmt([[
    import {what}{as} from "{module}";
    ]], {
        what = i(1, "thingies"),
        module = i(2, "module"),
        as = c(3, {
            t"",
            sn(nil, {
                t" as \"",
                f(function (import_name)
                    local parts = vim.split(import_name[1][1], "%/")
                    if parts[#parts] == "lodash" then
                        return "_"
                    else
                        return parts[#parts] or "name"
                    end
                end, { ai[2] }),
                t"\""
            })
        })
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
            args_str = args_str:gsub(', ', ',')
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

    s({trig = "for([%w_]*)", regTrig = true}, fmt([[
    for (int {index} = {start}; {indexrep} < {stop}; {indexpp}) {{
        {body}
    }}
    ]], {
        index = d(1, function (_, snip)
            local var = snip.captures[1]
            if var == "" then
                var = "i"
            end
            return sn(1,i(1, var))
        end),
        start = i(2, "0"),
        indexrep = rep(1),
        stop = i(3, "stop"),
        indexpp = d(4, function (_, snip)
            local var = snip.captures[1]
            if var == "" then
                var = "i"
            end
            var = var .. "++"
            return sn(1, i(1, var))
        end, { 1 }),
        body = i(0)
    })),

    s("m", fmt([[
    {name}({args}) {{
        {body}
    }}
    ]], {
        name = i(1, "name"),
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
}
