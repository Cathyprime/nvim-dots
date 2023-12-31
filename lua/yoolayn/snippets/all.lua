local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("all", {
    s(
    { trig = "{", wordTrig = false },
    { t { "{" }, i(0), t { "}" } },
    {}
    ),

    s(
    { trig = "(", wordTrig = false },
    { t { "(" }, i(0), t { ")" } },
    {}
    ),

    s(
    { trig = "[", wordTrig = false },
    { t { "[" }, i(0), t { "]" } },
    {}
    ),
})
