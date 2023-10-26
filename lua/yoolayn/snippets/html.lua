return {
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

	s("div", fmt([[
	<div {type}="{name}">
		{body}
	</div>
	]], {
		type = c(1, {
			t"class",
			t"id"
		}),
		name = i(2, "name"),
		body = i(0),
	})),

	s("tag", fmt([[
	<{name}{opts}>
		{body}
	</{repeatname}>
	]], {
		name = i(1, "name"),
		repeatname = rep(1),
		opts = c(2, {
			t"",
			sn(nil, fmt([[{class}="{name}"]], {
				class = c(1, {
					t" class",
					t" id",
				}),
				name = i(2, "name"),
			})),
		}),
		body = i(3),
	}))
}
