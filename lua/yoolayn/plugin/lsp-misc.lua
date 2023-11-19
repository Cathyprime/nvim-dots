return {
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		lazy = true,
		opts = {
			text = {
				spinner = "moon",
			},
			window = {
				blend = 0,
			},
		}
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {
			max_height = 6,
			doc_lines = 6,
			hint_prefix = ":",
			hint_enable = false,
			toggle_key = "<c-t>",
		},
		config = function(_, opts) require 'lsp_signature'.setup(opts) end
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		lazy = true,
		config = function()
			require("lsp_lines").setup()
			vim.diagnostic.config({
				virtual_text = false,
				virtual_lines = true
			})
		end,
	}
}
