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

ls.add_snippets("html", {
	s("html5", fmt([[
	<!DOCTYPE html>
	<html lang="{lang}">

		<head>
			<meta charset="{charset}">
			<meta name="viewport" content="width=device-width, initial-scale=1">
			<title>{title}</title>
			<link rel="stylesheet" href="{stylesheet}.css">
		</head>

		<body>
			{body}
		</body>

	</html>
	]], {
		lang = i(1, "en"),
		charset = i(2, "utf-8"),
		title = i(3, "title"),
		stylesheet = i(4, "styles"),
		body = i(0)
	})),
})
