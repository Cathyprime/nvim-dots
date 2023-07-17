return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {
			presets = {
				operators = false,
				motions = false,
				windows = false,
				nav = false,
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
		opts = {
			options = {
				globalstatus = true,
			},
		},
	},
	{
		"stevearc/dressing.nvim",
	},
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		event = "VeryLazy",
		config = function()
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				routes = {
					{
						filter = {
							event = "msg_show",
							any = {
								{ find = "%d+L, %d+B" },
								{ find = "; after #%d+" },
								{ find = "; before #%d+" },
							},
						},
						view = "mini",
					},
				},
				presets = {
					bottom_search = true,
					long_message_to_split = true,
					inc_rename = true,
				},
				cmdline = {
					view = "cmdline",
					format = {
						search_down = {
							view = "cmdline",
						},
						search_up = {
							view = "cmdline",
						},
					},
				},
			})
		end,
  		-- stylua: ignore
  		keys = {
  			{ "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
  			{ "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
  			{ "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
  			{ "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
  			{ "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
  			{ "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
  			{ "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
  		},
	},
	{
		"anuvyklack/help-vsplit.nvim",
		opts = {},
	},
	{
		"chentoast/marks.nvim",
		opts = {},
	},
	{
		"JellyApple102/easyread.nvim",
		opts = {
			filetypes = {},
		},
		cmd = "EasyreadToggle",
		keys = {
			{
				"<leader>er",
				":EasyreadToggle<CR>",
				desc = "Bionic Reading",
			},
		},
		ft = "txt",
	},
}
