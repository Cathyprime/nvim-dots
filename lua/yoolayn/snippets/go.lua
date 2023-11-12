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
		left = f(function(values)
			if values[1][1] == "" then
				return ""
			else
				return "("
			end
		end, { 3 }),
		right = f(function(values)
			if values[1][1] == "" then
				return ""
			else
				return ") "
			end
		end, { 3 }),
	})),

	s("m", fmt([[
	func ({receiver}) {name}({args}) {left}{return_val}{right}{{
		{body}
	}}
	]], {
		name = i(1, "name"),
		args = i(2),
		receiver = i(3),
		return_val = i(4),
		left = f(function(name)
			if name[1][1] == "" then
				return ""
			else
				return "("
			end
		end, { 4 }),
		right = f(function(name)
			if name[1][1] == "" then
				return ""
			else
				return ") "
			end
		end, { 4 }),
		body = i(0),
	})),

}
