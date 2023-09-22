local ls = require("luasnip")
local s = ls.snippet
local c = ls.choice_node
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
-- local rep = require("luasnip.extras").rep

ls.add_snippets("rust", {
    s("fn", fmt([[
    fn {funame}({argname}: {argtype}) -> {retype} {{
        {body}
    }}
    ]], {
        funame = i(1, "name"),
        argname = i(2, "arg"),
        argtype = i(3, "type"),
        retype = i(4, "RetType"),
        body = i(0, "unimplemented!")
    })),

    s("p", fmt([[println!({});]], {i(0)})),

    s("main", fmt([[
    fn main() {{
        {}
    }}
    ]], i(0, "unimplemented!"))),

    s("var", fmt([[let {mut}{name}: {type} = {value};]], {
        mut = c(1, {t "", t "mut "}),
        name = i(2, "name"),
        type = i(3, "type"),
        value = i(0, "value")
    })),

})

