local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
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
    s("feat", fmt([[
    feat{scope}: {message}

    {body}]], {
        scope = c(1, {
            sn(nil, fmt("({})", i(1, "scope"))),
            t("")
        }),
        message = i(2,"commit message"),
        body = i(0)
    })),

    s("fix", fmt([[
    fix{scope}: {message}

    {body}]], {
        scope = c(1, {
            sn(nil, fmt("({})", i(1, "scope"))),
            t("")
        }),
        message = i(2,"commit message"),
        body = i(0)
    })),

    s("style", fmt([[
    style{scope}: {message}

    {body}]], {
        scope = c(1, {
            sn(nil, fmt("({})", i(1, "scope"))),
            t("")
        }),
        message = i(2,"commit message"),
        body = i(0)
    })),

    s("refactor", fmt([[
    refactor{scope}: {message}

    {body}]], {
        scope = c(1, {
            sn(nil, fmt("({})", i(1, "scope"))),
            t("")
        }),
        message = i(2,"commit message"),
        body = i(0)
    })),

    s("cc", fmt([[
    {type}{scope}: {message}

    {body}]], {
        type = i(1),
        scope = c(2, {
            sn(nil, fmt("({})", i(1, "scope"))),
            t("")
        }),
        message = i(3,"commit message"),
        body = i(0)
    })),

    s("chore", fmt([[
    chore{scope}: {message}

    {body}]], {
        scope = c(1, {
            sn(nil, fmt("({})", i(1, "scope"))),
            t("")
        }),
        message = i(2,"commit message"),
        body = i(0)
    })),

    s("test", fmt([[
    test{scope}: {message}

    {body}]], {
        scope = c(1, {
            sn(nil, fmt("({})", i(1, "scope"))),
            t("")
        }),
        message = i(2,"commit message"),
        body = i(0)
    })),

    s("ci", fmt([[
    ci{scope}: {message}

    {body}]], {
        scope = c(1, {
            sn(nil, fmt("({})", i(1, "scope"))),
            t("")
        }),
        message = i(2,"commit message"),
        body = i(0)
    })),

    s("build", fmt([[
    build{scope}: {message}

    {body}]], {
        scope = c(1, {
            sn(nil, fmt("({})", i(1, "scope"))),
            t("")
        }),
        message = i(2,"commit message"),
        body = i(0)
    })),

    s("docs", fmt([[
    docs{scope}: {message}

    {body}]], {
        scope = c(1, {
            sn(nil, fmt("({})", i(1, "scope"))),
            t("")
        }),
        message = i(2,"commit message"),
        body = i(0)
    })),

    s("perf", fmt([[
    perf{scope}: {message}

    {body}]], {
        scope = c(1, {
            sn(nil, fmt("({})", i(1, "scope"))),
            t("")
        }),
        message = i(2,"commit message"),
        body = i(0)
    })),

    s("BREAK", fmt([[
    BREAKING CHANGE: {message}]], {
        message = i(0,"commit message"),
    })),

    s("remove", fmt([[
    remove{scope}: {message}

    {body}]], {
        scope = c(1, {
            sn(nil, fmt("({})", i(1, "scope"))),
            t("")
        }),
        message = i(2,"commit message"),
        body = i(0)
    })),

}
