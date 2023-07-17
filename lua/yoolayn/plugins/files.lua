return {
	"stevearc/oil.nvim",
	keys = {
		{
			"<leader>e",
			function()
				require("oil").open()
			end,
			desc = "open files",
		},
	},
	opts = {},
}
