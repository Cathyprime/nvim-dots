return {
	{
		"numToStr/Comment.nvim",
		event = {"BufEnter", "BufReadPre"},
		opts = {},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		dependencies = "hrsh7th/nvim-cmp",
		config = function()
			require("nvim-autopairs").setup({})
			require("nvim-autopairs").remove_rule('"')
			require("nvim-autopairs").remove_rule("'")
			require("nvim-autopairs").remove_rule('`')
			require("yoolayn.config.cmp-pairs")
			require("yoolayn.config.pair-customrules")
		end
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
		"sindrets/diffview.nvim",
		opts = {},
		cmd = {
			"DiffviewClose",
			"DiffviewFileHistory",
			"DiffviewFocusFiles",
			"DiffviewLog",
			"DiffviewOpen",
			"DiffviewRefresh",
			"DiffviewToggleFiles",
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
	},
	{
		"ziontee113/color-picker.nvim",
		opts = {},
		keys = {
			{ "<leader>c", "<cmd>PickColor<cr>" }
		}
	},
	{
		"folke/flash.nvim",
		config = function()
			require("yoolayn.config.flash")
		end,
		keys = {
			{
				"r",
				function()
					require("flash").remote()
				end,
				mode = "o",
			},
			{
				"gr",
				function()
					require("flash").treesitter_search()
				end,
				mode = "x"
			},
			{
				"R",
				function()
					require("flash").treesitter()
				end,
				mode = { "o", "x" }
			}
		}
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		cmd = "DBUIToggle",
	},
	{
		"anuvyklack/hydra.nvim" ,
	},
	{
		"dohsimpson/vim-macroeditor",
		cmd = "MacroEdit",
	},
}
