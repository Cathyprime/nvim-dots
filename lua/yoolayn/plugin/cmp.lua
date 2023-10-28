return {
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
		},
		config = function()
			require("yoolayn.config.cmp")
			require("yoolayn.config.cmp-colors")
		end,
	},
}
