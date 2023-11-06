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
