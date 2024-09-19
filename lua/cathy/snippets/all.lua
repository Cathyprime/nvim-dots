local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
-- local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
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

local function begin_line_snip(trig)
    local trigger = "^%s*"..trig.."*$"
    local comment = require("ts_context_commentstring").calculate_commentstring({
        location = require("ts_context_commentstring.utils").get_cursor_location(),
    })
    comment = vim.F.if_nil(comment, "// %s")
    local args = {
        trig = trig,
        snippetType = "autosnippet",
        condition = function(line_to_cursor, matched_trigger, _)
            if matched_trigger == nil or line_to_cursor == nil then
                return false
            end
            return line_to_cursor:match(trigger)
        end
    }
    return s(args, fmt(string.format(comment .. "{}", string.upper(trig) .. ":"), {
        i(0)
    }))
end

return {
    begin_line_snip("todo"),
    begin_line_snip("fixme"),
    begin_line_snip("hack"),
    begin_line_snip("note"),
}
