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
				"<leader>fs",
				function()
					require("telescope.builtin").lsp_document_symbols(
					{
						symbols = {
							"Class",
							"Function",
							"Method",
							"Constructor",
							"Interface",
							"Module",
							"Struct",
							"Trait",
							"Field",
							"Property",
						}
					})
				end,
				desc = "find symbols"
			},

			-- git
			{ "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "find files" },
			{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "status" },
			{ "<leader>gc", "<cmd>Telescope git_status<cr>", desc = "commits" },
		},
	},
}
