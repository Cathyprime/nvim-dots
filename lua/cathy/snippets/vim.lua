local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
local c = ls.choice_node
-- local d = ls.dynamic_node
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
    function{clear} {name}({args})
        {body}
    endfunction
    ]], {
        clear = c(1, {
            t"!",
            t"",
        }),
        name = i(2, "name"),
        args = i(3),
        body = i(0)
    })),

    s("if", fmt([[
    if {condition}
        {body}
    endif
    ]], {
        condition = i(1, "conditon"),
        body = c(2, {
            i(1),
            sn(nil, fmt([[
            {body1}
            else
                {body2}
            ]], {
                body1 = i(1),
                body2 = i(2),
            }))
        })
    })),

    s({trig = [[\%( \{4\}\| \)\?eif]], hidden = true, regTrig = true, trigEngine = "vim"}, fmt([[{}]], {
        isn(1, {
            t"elseif ", i(1, "condition"), t({"", "\t"}), i(2)
        }, "$PARENT_INDENT")
    })),

    s("aug", fmt([[
    augroup {name}
        {clear}{body}
    augroup END
    ]], {
        clear = c(1, {
            t{"au!", "\t"},
            t"",
        }),
        name = i(2, "name"),
        body = i(0)
    })),

    s("au", fmt([[
    au {event} {pattern} {command}
    ]], {
        event = i(1, "event"),
        pattern = c(2, {
            i(1, "pattern"),
            t"*",
            t"<buffer>",
        }),
        command = i(3, "command")
    })),

    s("while", fmt([[
    while {condition}
        {body}
    endwhile
    ]], {
        condition = i(1, "condition"),
        body = i(0)
    })),

    s("for", fmt([[
    for {iter} in {iteree}
        {body}
    endfor
    ]], {
        iter = i(1, "iterator"),
        iteree = c(2, {
            sn(nil, fmt([[{}]], { i(1, "variable") })),
            sn(nil, fmt([[range({}, {})]], {i(1, "start"), i(2, "inclusive")})),
            sn(nil, fmt("[{}]", i(1, "list"))),
        }),
        body = i(0)
    })),

    s("if?", fmt([[
    {condition} ? {expr1} : {expr2}
    ]], {
        condition = i(1, "condition"),
        expr1 = i(2, "expression"),
        expr2 = i(3, "expression"),
    })),

    s("map", fmt([[
    {mode}{nore}map {buffer}{silent}{lhs} {rhs}
    ]], {
        mode = i(1, "n"),
        nore = c(2, {
            t"nore",
            t"",
        }),
        buffer = c(3, {
            t"",
            t"<buffer> ",
        }),
        silent = c(4, {
            t"",
            t"<silent> ",
        }),
        lhs = i(5, "lhs"),
        rhs = i(6, "rhs"),
    }))

}
