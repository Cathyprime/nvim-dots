return {
	{
		"numToStr/Comment.nvim",
		event = {"BufEnter", "BufReadPre"},
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		event = { "BufNewFile", "BufReadPost", "InsertEnter" },
		opts = {
			keymaps = {
				insert = "<c-s>",
				insert_line = "<c-s><c-s>",
			}
		}
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
		"gsuuon/tshjkl.nvim",
		config = true,
		keys = {
			{ "<m-v>" }
		}
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
			{
				[[\s]],
				[[<cmd>exe v:count1 . "ToggleTermSendCurrentLine"<cr>]],
				mode = "n"
			},
			{
				[[\s]],
				[[<cmd>exe v:count1 . "ToggleTermSendVisualSelection"<cr>]],
				mode = "v"
			}
		}
	},
	{
		"chomosuke/term-edit.nvim",
		ft = "toggleterm",
		opts = {
			prompt_end = [[>>= ]]
		}
	},
	{
		"kevinhwang91/nvim-fundo",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			require('fundo').install()
		end,
	},
	{
		-- TODO: remake it myself
		"ej-shafran/compile-mode.nvim",
		branch = "latest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "m00qek/baleia.nvim", tag = "v1.3.0" },
		},
		config = true,
		cmd = { "Compile" }
	},
	{
		"nvim-pack/nvim-spectre",
		opts = {},
		keys = {
			{
				"<leader>r",
				"<cmd>lua require('spectre').toggle()<cr>"
			}
		}
	}
}
