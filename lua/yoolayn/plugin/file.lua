return {
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
			vim.keymap.set("n", "<leader>e", "<cmd>split| Oil<cr>", { silent = true })
			vim.keymap.set("n", "<leader>fe", "<cmd>Oil<cr>", { silent = true })
			vim.keymap.set("n", "<leader>fE", "<cmd>vert Oil<cr>", { silent = true })
		end
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			source_selector	= {
				winbar = true,
				sources = {
					{
						source = "git_status",
						display_name = " 󰊢 Git "
					},
					{
						source = "document_symbols",
						display_name = "  Symbols "
					},
					{
						source = "buffers",
						display_name = " 󰈚 Buffers "
					},
				},
			},
			sources = { "git_status", "document_symbols", "buffers" }
		},
		keys = {
			{ "<leader>n", "<cmd>Neotree position=bottom<cr>" }
		},
		cmd = { "Neotree" }
	}
}
