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
				stogglebuf = "",
				sclear = "z<Tab>",
				pscrollup = "<c-y>",
				pscrolldown = "<c-e>",
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
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {},
		keys = {
			{
				"<c-w>t",
				[[<cmd>exe v:count1 . "ToggleTerm"<cr>]],
			},
			{
				"<c-w>T",
				[[<cmd>exe v:count1 . "ToggleTerm size=70 direction=vertical"<cr>]]
			},
		}
	},
	{
		"chomosuke/term-edit.nvim",
		ft = "toggleterm",
		opts = {
			prompt_end = [[>>= ]]
		}
	}
}
