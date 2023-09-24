
local ls = require("luasnip")
local s = ls.snippet
local c = ls.choice_node
local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local i = ls.insert_node
-- local f = ls.function_node
-- local d = ls.dynamic_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
-- local rep = require("luasnip.extras").rep

ls.add_snippets("gitcommit", {
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

	s("refractor", fmt([[
	refractor{scope}: {message}

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

})
