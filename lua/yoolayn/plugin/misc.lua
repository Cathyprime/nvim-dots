return {
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>" }
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
		"anuvyklack/hydra.nvim" ,
	},
	{
		"dohsimpson/vim-macroeditor",
		cmd = "MacroEdit",
	},
	{
		"kevinhwang91/nvim-fundo",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			require("fundo").install()
		end,
	},
	{
		"stevearc/dressing.nvim",
		opts = {}
	},
	{
		"stevearc/oil.nvim",
		opts = {
			default_file_explorer = true,
			columns = {
				"permissions",
				"size",
				"mtime",
				"icon",
			},
			keymaps = {
				["<c-c>q"] = "actions.close"
			}
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function(opts)
			require("oil").setup(opts.opts)
			vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { silent = true })
		end
	},
	{
		"Vigemus/iron.nvim",
		cmd = "IronRepl",
		config = function()
			require("iron.core").setup({
				config = {
					repl_open_cmd = "vertical botright 70 split",
				},
				keymaps = {
					send_motion = "<localleader><localleader>",
					visual_send = "<localleader><localleader>",
					send_file = "<localleader><localleader>f",
					send_line = "<localleader><localleader><localleader>",
					cr = "<localleader><localleader><cr>",
					interrupt = "<localleader><localleader><c-c>",
					exit = "<localleader><localleader><c-d>",
					clear = "<localleader><localleader><c-l>",
				}
			})
		end
	}
}
