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
-- local rep = require("luasnip.extras").rep

ls.add_snippets("vim", {

	s("fn", fmt([[
	function{clear} {name}()
		{body}
	endfunction
	]], {
		clear = c(1, {
			t"!",
			t"",
		}),
		name = i(2, "name"),
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

	s({trig = ".*eif", regTrig = true,}, fmt([[
	elseif {condition}
		{body}
	]], {
		condition = i(1, "condition"),
		body = i(0)
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

})
