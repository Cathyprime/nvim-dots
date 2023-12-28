return {
	{
		"echasnovski/mini.indentscope",
		event = { "BufReadPost", "BufNewFile" },
		version = false,
		opts = {
			symbol = "",
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
		"echasnovski/mini.operators",
		version = false,
		opts = {
			sort = {
				prefix = "",
				func = nil
			}
		},
		keys = {
			{ "g=", mode = { "n", "x" } },
			{ "gx", mode = { "n", "x" } },
			{ "gm", mode = { "n", "x" } },
			{ "gr", mode = { "n", "x" } },
			-- { "gS", mode = { "n", "x" } },
		}
	},
	{
		"echasnovski/mini.starter",
		version = false,
		opts = {

		}
	}
}
