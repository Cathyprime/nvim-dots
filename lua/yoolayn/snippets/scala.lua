return {
	s("fn", fmt([[
	{annotation}def {name}{args}: {retType} = {{
		{body}
	}}
	]], {
		annotation = c(1, {
			t"",
			t({"@annotation.tailrec", ""})
		}),
		name = i(2, "name"),
		args = c(3, {
			t"",
			sn(nil, { t"(",i(1, "args") ,t")" }),
		}),
		retType = i(4, "Type"),
		body = i(0)
	})),

	s("p", fmt([[
	println({val})
	]], {
		val = i(1)
	})),
}
