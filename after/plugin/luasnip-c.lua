local ls = require("luasnip")
local s = ls.snippet
local c = ls.choice_node
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local t = ls.text_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("c", {
	s("fn", fmt([[
	{type} {name}({args}) {{
		{body}
	}}
	]], {
		type = i(1, "void"),
		name =i(2, "name"),
		args = i(3),
		body = i(0)
	})),

	s("main", fmt([[
	{stdio}int main(int argc, char *argv[]) {{
		{body}
	}}
	]], {
		stdio = c(1, {
			t"",
			t{"#include <stdio.h>", "", ""},
		}),
		body = i(0),
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
		end),
		body = i(0)
	})),

	s("inc", fmt([[
	#include {}
	]], {
		c(1, {
			sn(nil, {
				t[["]],
				i(1, "module"),
				t[["]],
			}),
			sn(nil, {
				t"<",
				i(1, "module"),
				t">",
			})
		})
	})),

	s("def", fmt([[
	#define {} {}
	]], {
		i(1, "name"),
		i(2, "content")
	}))
})
