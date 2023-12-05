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
				prefix = "gS"
			}
		},
		keys = {
			{ "g=", mode = { "n", "x" } },
			{ "gx", mode = { "n", "x" } },
			{ "gm", mode = { "n", "x" } },
			{ "gr", mode = { "n", "x" } },
			{ "gS", mode = { "n", "x" } },
		}
	},
	{
		"echasnovski/mini.files",
		version = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		opts = {},
		keys = {
			{ "<leader>e", function()
				require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
			end }
		}
	},
	{
		"echasnovski/mini.move",
		opts = {},
		keys = {
			{ "<m-h>", mode = {"n", "x"} },
			{ "<m-j>", mode = {"n", "x"} },
			{ "<m-k>", mode = {"n", "x"} },
			{ "<m-l>", mode = {"n", "x"} },
		}
	}
}
