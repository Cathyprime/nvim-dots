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
		"ThePrimeagen/vim-be-good",
		cmd = "VimBeGood",
	},
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		opts = {
			func_map = {
				open = "<CR>",
				openc = "o",
				drop = "",
				tabdrop = "",
				tab = "",
				tabb = "",
				tabc = "",
				split = "",
				vsplit = "",
				prevfile = "",
				nextfile = "",
				prevhist = "<",
				nexthist = ">",
				lastleave = "",
				stoggleup = "",
				stoggledown = "<Tab>",
				stogglevm = "<Tab>",
				stogglebuf = "b<Tab>",
				sclear = "z<Tab>",
				pscrollup = "<C-u>",
				pscrolldown = "<C-d>",
				pscrollorig = "",
				ptogglemode = "P",
				ptoggleitem = "",
				ptoggleauto = "p",
				filter = "zn",
				filterr = "zN",
				fzffilter = "",
			}
		}
	}
}
