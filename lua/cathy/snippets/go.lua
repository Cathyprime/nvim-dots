local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
-- local c = ls.choice_node
local d = ls.dynamic_node
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

local right = function(values)
    if values[1][1] == "" then
        return ""
    end
    local parts = vim.split(values[1][1], "%,")
    if #parts > 1 then
        return ") "
    else
        return " "
    end
end

local left = function(values)
    if values[1][1] == "" then
        return ""
    end
    local parts = vim.split(values[1][1], "%,")
    if #parts > 1 then
        return "("
    else
        return ""
    end
end

return {
    s("p", fmt([[
    fmt.Println({args})
    ]], {
        args = i(1, "args"),
    })),

    s("pf", fmt([[
    fmt.Printf({args})
    ]], {
        args = i(1, "args")
    })),

    s("ok", fmt([[
    if ok {{
    	{body}
    }}
    ]], {
        body = i(0)
    })),

    s("err", fmt([[
    if err != nil {{
    	{body}
    }}
    ]], {
        body = i(0, "log.Fatal(err)")
    })),

    s("fn", fmt([[
    func{space}{name}({args}) {left}{return_val}{right}{{
    	{body}
    }}
    ]], {
        space = f(function(name)
            if name[1][1] == "" then
                return ""
            else
                return " "
            end
        end, { 1 }),
        name = i(1),
        args = i(2),
        return_val = i(3),
        body = i(0),
        left = f(left, { 3 }),
        right = f(right, { 3 }),
    })),

    s("m", fmt([[
    func ({self}{receiver}) {name}({args}) {left}{return_val}{right}{{
    	{body}
    }}
    ]], {
        name = i(1, "name"),
        self = f(function(name)
            local str = name[1][1]
            if str == "" then
                return ""
            end
            local first = str:sub(1, 1)
            if first == " " then
                return "self"
            elseif first == "*" then
                return "self "
            else
                return ""
            end
        end, { 3 }),
        args = i(2),
        receiver = i(3),
        return_val = i(4),
        left = f(left, { 4 }),
        right = f(right, { 4 }),
        body = i(0),
    })),
}
