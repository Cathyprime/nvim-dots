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
				[[<cmd>exe "ToggleTermSendCurrentLine"<cr>]],
				mode = "n"
			},
			{
				[[\s]],
				[[:<c-u>exe v:count1 . "ToggleTermSendVisualSelection"<cr>]],
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
}
