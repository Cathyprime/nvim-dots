return {
	{
		"numToStr/Comment.nvim",
		event = {"BufEnter", "BufReadPre"},
		opts = {},
	},
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>" }
		}
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = {},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>" }
		}
	},
	{
		"lewis6991/gitsigns.nvim",
		event = {"BufEnter", "BufReadPre"},
		opts = {
			on_attach = function(bufnr)
				vim.keymap.set(
				{ "o", "x" },
				"ih",
				":<C-u>Gitsigns select_hunk<cr>",
				{
					desc = "inner hunk",
					buffer = bufnr
				})
			end,
		}
	},
	{
		"dstein64/vim-startuptime",
		cmd = {
			"StartupTime"
		}
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		opts = {
			symbol = "│",
		},
	},
	{
		"echasnovski/mini.align",
		version = false,
		opts = {
			start = '',
			start_with_preview = 'ga',
		},
	}
}
