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
                t"): ",
                i(4, "retType"),
                t" =>"
            }),
            sn(nil, {
                t"function ",
                i(1, "name"),
                t"(",
                i(2),
                t"): ",
                i(3, "retType")
            }),
            sn(nil, {
                c(1, {
                    t"const ",
                    t"let ",
                }),
                i(2, "name"),
                t" = function(",
                i(3),
                t"): ",
                i(4, "retType")
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
    {scope} {name}: {type}{value};
    ]], {
        scope = c(1, {
            t"const",
            t"let",
        }),
        name = i(2, "name"),
        value = c(4, {
            sn(nil, {
                t" = ",
                i(1, "value")
            }),
            t"",
        }),
        type = i(3, "type"),
    })),

    s("()", fmt([[
    ({args}): {type} => {{{body}}}
    ]], {
        args = i(1),
        body = i(0),
        type = i(2, "retType")
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
                t": ",
                i(3, "type"),
                t" = ",
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
                t"}",
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
        module = i(3, "module"),
        as = c(2, {
            t"",
            sn(nil, {
                t" as ",
                f(function (import_name)
                    local parts = vim.split(import_name[1][1], "%/")
                    if parts[#parts] == "lodash" then
                        return "_"
                    else
                        return parts[#parts] or "name"
                    end
                end, { ai[3] }),
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
    {properties}constructor({args}) {{
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

            for index, arg in ipairs(args_split) do
                local private = ""
                if string.find(args[2][index], "_") then
                    private = "_"
                end
                local name = vim.split(arg, ':')[1]
                table.insert(nodes, "this." .. private .. name .. " = " .. name .. ";")
            end
            return isn(nil, t(nodes), "$PARENT_INDENT\t")
        end, { 1, ai[3] }),
        body = i(0),
        properties = d(3, function (args)
            local args_str = args[1][1]
            args_str = args_str:gsub(' ', '')
            if args_str == "" then
                return sn(nil, {t("")})
            end
            local args_split = vim.split(args_str, ',')
            local nodes = {}

            for index, arg in ipairs(args_split) do
                local name = arg:gsub(':', ': ')
                local isLast = index == #args_split
                local str = {name .. ";", ""}
                if isLast then
                    table.insert(str, "")
                end
                table.insert(nodes, isn(index, {
                    c(1, {
                        t"private _",
                        t"public ",
                        t"protected ",
                    }),
                    t(str),
                }, "$PARENT_INDENT"))
            end
            return sn(nil, nodes)
        end, { 1 })
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
