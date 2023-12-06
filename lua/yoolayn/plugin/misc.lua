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
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		config = function()
			local harpoon = require("harpoon")
			---@diagnostic disable-next-line: missing-parameter
			harpoon:setup()
			local function map(lhs, rhs, opts)
				vim.keymap.set("n", lhs, rhs, opts or {})
			end
			map("<leader>a", function() harpoon:list():append() end)
			map("<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
			map("<c-h><c-h>", function() harpoon:list():select(1) end)
			map("<c-h><c-j>", function() harpoon:list():select(2) end)
			map("<c-h><c-k>", function() harpoon:list():select(3) end)
			map("<c-h><c-l>", function() harpoon:list():select(4) end)
		end
	},
	{
		"stevearc/dressing.nvim",
		opts = {}
	},
	{
		"stevearc/oil.nvim",
		opts = {
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
		keys = {
			{ "<leader>e", "<cmd>Oil<cr>" }
		}
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
					send_file = "<localleader>rf",
					send_line = "<localleader><cr>",
					cr = "<localleader><localleader><cr>",
					interrupt = "<localleader><c-c>",
					exit = "<localleader><c-d>",
					clear = "<localleader><c-l>",
				}
			})
		end
	}
}
