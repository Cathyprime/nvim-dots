return {

	s("test", fmt([[
	def test_{name}(self{args}) -> None:
		{body}
	]], {
		name = i(1, "name"),
		args = i(2),
		body = i(0)
	})),

	s("prop", fmt([[
	@property
	def {name}(self) -> {type}:
		return self._{repName1}

	@{repName2}.setter
	def {repName3}(self, value: {repType}) -> None:
		self._{repName4} = value
	]], {
		name = i(1, "name"),
		repName1 = rep(1),
		repName2 = rep(1),
		repName3 = rep(1),
		repName4 = rep(1),
		type = i(2, "type"),
		repType = rep(2),
	})),

	s("unittest", fmt([[
	import unittest


	class {name}(unittest.TestCase):

		{body}


	if __name__ == '__main__':
		unittest.main()
	]], {
		name = i(1, "name"),
		body = i(0)
	})),

	s("fn", fmt([[
	def {name}({args}) -> {type}:
		{body}
	]], {
		name = i(1, "name"),
		args = i(2),
		type = i(3, "RetType"),
		body = i(0)
	})),

	s("m", fmt([[
	def {name}(self{args}) -> {type}:
		{body}
	]], {
		name = i(1, "name"),
		args = i(2),
		type = i(3, "RetType"),
		body = i(0)
	})),

	s("p", fmt([[print({})]], {
		i(0),
	})),

	s("if", fmt([[
	if {cond}:
		{body}
	]],{
		cond = i(1, "condition"),
		body = c(2, {
			i(1),
			isn(nil, fmt([[
			{body1}
			else:
				{body2}
			]], {
				body1 = i(1),
				body2 = i(2)
			}), "$PARENT_INDENT")
		})
	})),

	s({trig = [[\%( \{4\}\|	\)\?eif]], hidden = true, regTrig = true, trigEngine = "vim"}, fmt([[
	elif {cond}:
		{body}
	]], {
		cond = i(1, "condition"),
		body = i(2)
	})),

	s("class", fmt([[
	class {name}{inheritance}:

		{body}
	]], {
		name = i(1, "name"),
		inheritance = c(2, {
			t"",
			sn(nil, {
				t"(",
				i(1, "class"),
				t")"
			})
		}),
		body = i(0)
	})),

	s("init", fmt([[
	def __init__(self{args}) -> None:
		{assign}{body}
	]], {
		args = i(1),
		assign = d(2, function (args)
			local args_str = args[1][1]
			args_str = args_str:gsub(' ', '')
			args_str = args_str:sub(2) or ""
			if args_str == "" then
				return sn(nil, {t("")})
			end
			local args_split = vim.split(args_str, ',')
			local nodes = {}

			for _, arg in ipairs(args_split) do
				local trimmed = vim.split(arg, "=")[1] or arg
				local name = vim.split(trimmed, ":")[1] or ""
				local type = vim.split(trimmed, ":")[2] or ""
				if type ~= "" then
					type = ": " .. type
				end
				table.insert(nodes, "self." .. name .. type .. " = " .. name)
			end
			return isn(nil, t(nodes), "$PARENT_INDENT\t")
		end, { 1 }),
		body = i(0)
	})),

}
