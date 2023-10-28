return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufEnter", "BufReadPost" },
		dependencies = {
			{ "folke/neodev.nvim", opts = {} },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"j-hui/fidget.nvim",
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		},
		config = function()
			require("yoolayn.config.lsp")
		end,
	},
}
