return {
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "UndoTreetoggle<cr>" }
		}
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>" }
		}
	},
	{
		"lewis6991/gitsigns.nvim",
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
	},}
