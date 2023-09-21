local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet
-- local isn = ls.snippet
local i = ls.insert_node
local f = ls.function_node
-- local d = ls.dynamic_node
-- local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
-- local rep = require("luasnip.extras").rep

ls.add_snippets("lua", {
    s("req", fmt([[local {varname} = require "{path}"]], {
        varname = f(function(import_name)
            local parts = vim.split(import_name[1][1], ".", {plain = true})
            return parts[#parts] or ""
        end, {1}),
        path = i(1)
    })),
    s("fn", fmt([[
    local function {fun_name}()
        {body}
    end
    ]], {
        fun_name = i(1, "name"),
        body = i(0, "???")
    })),
    s("setup", fmt("setup({{{}}})", {
        i(0)
    })),
    s("var", fmt("local {} = {}", {
        i(1, "name"),
        i(0, "value")
    })),
    s("p", fmt("print(\"{}\")", {
        i(0)
    })),
    s("noti", fmt([[vim.notify("{}", {}, {{{}}})]], {
        i(1, "message"),
        i(2, "loglevel"),
        i(0, "")
    }))
})
