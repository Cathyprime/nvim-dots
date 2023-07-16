return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.2',
		dependencies = {
			'nvim-lua/plenary.nvim'
		},
		keys = {
			-- general
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "find files" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "find Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "help tags" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "live grep" },
			{
				"<leader>fg",
				function()
					require(telescope.builtin).grep_string({ search = vim.fn.input("Grep > ") })
				end,
				desc = "grep current file"
			},
			-- git
			{ "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "find files" },
			{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "status" },
			{ "<leader>gc", "<cmd>Telescope git_status<cr>", desc = "commits" },
		},
	},
}
