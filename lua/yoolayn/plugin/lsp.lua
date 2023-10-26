return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufEnter", "BufReadPost" },
		dependencies = {
			{ "folke/neodev.nvim", opts = {} },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"dgagn/diagflow.nvim",
			"j-hui/fidget.nvim",
		},
		config = function()
			require("yoolayn.config.lsp")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = {"InsertEnter"},
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"octaltree/cmp-look",
			"hrsh7th/cmp-path",
		},
		config = function()
			require("yoolayn.config.cmp")
		end
	}
}
