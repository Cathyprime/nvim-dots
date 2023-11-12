return {
	s("pln", fmt([[
	fmt.Println({args})
	]], {
		args = i(1, "args"),
	})),

	s("pf", fmt([[
	fmt.Printf({args})
	]], {
		args = i(1, "args")
	})),

	s("fn", fmt([[
	func {name}({args}) {{
		{body}
	}}
	]], {
		name = i(1, "name"),
		args = i(2),
		body = i(0),
	})),
}
