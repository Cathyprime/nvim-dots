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

ls.add_snippets("python", {
	s("unitteststart", fmt([[
	import unittest


	class {name}(unittest.TestCase):
		{body}
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
				local name = vim.split(arg, ":")[1] or ""
				local type = vim.split(arg, ":")[2] or ""
				if type ~= "" then
					type = ": " .. type
				end
				table.insert(nodes, "self." .. name .. type .. " = " .. name)
			end
			return isn(nil, t(nodes), "$PARENT_INDENT\t")
		end, { 1 }),
		body = i(0)
	})),

})
