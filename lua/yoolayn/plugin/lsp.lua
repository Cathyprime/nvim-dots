return {
	"VonHeikemen/lsp-zero.nvim",
	event = {"BufEnter", "BufReadPre"},
	branch = "v2.x",
	dependencies = {
		"neovim/nvim-lspconfig",             -- Required
		"williamboman/mason.nvim",           -- Optional
		"williamboman/mason-lspconfig.nvim", -- Optional
		"hrsh7th/nvim-cmp",     -- Required
		"hrsh7th/cmp-nvim-lsp", -- Required
		"L3MON4D3/LuaSnip",     -- Required
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lua",
		"octaltree/cmp-look",
		"hrsh7th/cmp-path",
	},
	config = function()
		require("yoolayn.config.lsp")
	end,
}
