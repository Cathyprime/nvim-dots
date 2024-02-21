---@diagnostic disable: undefined-global

return {
    s("kv", {
        i(1, "key"),
        t(" = "),
        i(0, "value"),
        t(",")
    }),

    s("kfn", fmt([[
    {key} = function({args})
        {body}
    end
    ]], {
        key = i(1, "key"),
        args = i(2),
        body = i(3, "???")
    })),

    s("ktb", fmt([[
    {key} = {{
        {body}
    }}
    ]], {
        key = i(1, "key"),
        body = i(0)
    })),

    s("req", fmt([[local {varname} = require("{path}")]], {
        varname = f(function(import_name)
            local parts = vim.split(import_name[1][1], "%.")
            local str = parts[#parts] or ""
            str = str:gsub("-", "_") or str
            return str
        end, {1}),
        path = i(1)
    })),

    s("reqc", fmt([[require("{}").{}({})]], {
        i(1, "module"),
        i(2, "setup"),
        i(0)
    })),

    s("fn", fmt([[
    {scope}function{space}{name}({args})
        {body}
    end
    ]], {
        scope = f(function(name)
            if name[1][1] == "" then
                return ""
            elseif string.match(name[1][1], "^[A-Z_]+$")  then
                return ""
            else
                return "local "
            end
        end, { 1 }),
        space = f(function(name)
            if name[1][1] == "" then
                return ""
            else
                return " "
            end
        end, { 1 }),
        name = i(1),
        args = i(2),
        body = i(0)
    })),

    s("setup", fmt("setup({{{}}})", {
        i(0)
    })),

    s("var", fmt("{}{} = {}", {
        f(function (name)
            if string.match(name[1][1], "^[A-Z_]+$") or name[1][1] == "" then
                return ""
            else
                return "local "
            end
        end, { 1 }),
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

    s("fori", fmt([[
    for {var}={start},{fin} do
        {body}
    end
    ]], {
        var = i(1, "i"),
        start = i(2, "start"),
        fin = i(3, "inclusive"),
        body = i(0)
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
        value = i(3, "value"),
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

    s("m", fmt([[
    function M.{name}({args})
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
            i(1),
            isn(nil, fmt([[
            {body1}
            else
                {body2}
            ]], {
                body1 = i(1),
                body2 = i(2)
            }), "$PARENT_INDENT")
        })
    })),

    s({trig = [[\%( \{4\}\| \)\?eif]], hidden = true, regTrig = true, trigEngine = "vim"}, fmt([[
    elseif {cond} then
        {body}
    ]], {
        cond = i(1, "condition"),
        body = i(2)
    })),

    s("autocmd", fmt([[
    vim.api.nvim_create_autocmd({event}, {{
        once = {once},{pattern}
        {fn}
    }})
    ]], {
        event = c(1, {
            sn(nil, fmt([["{}"]], { i(1, "event") })),
            sn(nil, fmt([[{<>}]], { i(1, "event") }, { delimiters = "<>" })),
        }),
        once = c(2, {
            t"false",
            t"true",
        }),
        pattern = c(3, {
            t"",
            isn(nil, {
                t{ "", "pattern = " },
                c(1, {
                    sn(nil, fmt([["{}",]], { i(1, "pattern") })),
                    sn(nil, fmt("{<>},", { i(1, "patterns") }, { delimiters = "<>" })),
                })
            }, "$PARENT_INDENT\t")
        }),
        fn = c(4, {
            isn(nil, fmt([[
            callback = function({args})
                {body}
            end
            ]], {
                args = i(1),
                body = i(2),
            }), "$PARENT_INDENT\t"),
            sn(nil, fmt([[command = "{}"]], { i(1, "command") })),
        }),
    }))

}
