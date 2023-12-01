return {
	{
		"lewis6991/gitsigns.nvim",
		event = {"BufEnter", "BufReadPre"},
		opts = {
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				vim.keymap.set(
					{ "o", "x" },
					"ih",
					"<cmd>Gitsigns select_hunk<cr>",
					{ desc = "inner hunk", buffer = bufnr}
				)
				vim.keymap.set(
					{ "n" },
					"<leader>gs",
					gs.stage_hunk,
					{ buffer = bufnr }
				)
				vim.keymap.set(
					{ "n" },
					"<leader>gb",
					function() gs.blame_line({ full = true }) end,
					{ buffer = bufnr }
				)
				vim.keymap.set(
					{ "n" },
					"<leader>gr",
					gs.reset_hunk,
					{ buffer = bufnr }
				)
			end,
		}
	},
	{
		"sindrets/diffview.nvim",
		opts = {
			keymaps = {
				file_panel = {
					{
						"n", "cc",
						"<Cmd>G commit <bar> wincmd J<CR>",
						{ desc = "Commit staged changes" },
					},
					{
						"n", "cvc",
						"<Cmd>G commit --verbose <bar> wincmd J<CR>",
						{ desc = "Commit staged changes" },
					},
					{
						"n", "ca",
						"<Cmd>G commit --amend <bar> wincmd J<CR>",
						{ desc = "Amend the last commit" },
					},
					{
						"n", "c<space>",
						":G commit ",
						{ desc = "Populate command line with \":G commit \"" },
					},
				},
			}
		},
		cmd = {
			"DiffviewClose",
			"DiffviewFileHistory",
			"DiffviewFocusFiles",
			"DiffviewLog",
			"DiffviewOpen",
			"DiffviewRefresh",
			"DiffviewToggleFiles",
		},
		keys = {
			{
				"<leader>gd",
				"<cmd>DiffviewOpen<cr>"
			},
			{
				"<leader>gc",
				"<cmd>DiffviewClose<cr>"
			}
		}
	},
}
