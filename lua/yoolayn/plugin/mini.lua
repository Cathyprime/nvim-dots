return {
	{
		"echasnovski/mini.indentscope",
		event = { "BufReadPost", "BufNewFile" },
		version = false,
		opts = {
			symbol = "│",
		},
	},
	{
		"echasnovski/mini.align",
		-- keys = { { "ga" } },
		version = false,
		opts = {
			mappings = {
				start = "",
				start_with_preview = "ga",
			},
		},
	},
	{
		"echasnovski/mini.splitjoin",
		version = false,
		keys = { { "gs" } },
		opts = {
			mappings = {
				toggle = "gs",
			},
		},
	},
}
