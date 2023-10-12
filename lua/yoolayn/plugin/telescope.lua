return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				layout_strategy = "horizontal",
				layout_config = {
					height = 0.90,
					width = 0.90,
					preview_cutoff = 120,
					horizontal = { preview_width = 0.50 },
					vertical = { width = 0.55, height = 0.9, preview_cutoff = 0 },
					prompt_position = "bottom",
				},
				mappings = {
					i = {
						["<C-l>"] = function (...)
							return actions.smart_send_to_loclist(...)
						end,
						["<C-q>"] = function (...)
							return actions.smart_send_to_qflist(...)
						end,
						["<C-u>"] = false,
						["<C-e>"] = function(...)
							return actions.preview_scrolling_down(...)
						end,
						["<C-y>"] = function(...)
							return actions.preview_scrolling_up(...)
						end,
						["<C-j>"] = function(...)
							return actions.move_selection_next(...)
						end,
						["<C-k>"] = function(...)
							return actions.move_selection_previous(...)
						end,
					},
				},
			},
		})
	end,
	keys = {
		{
			"<leader>ff",
			"<cmd>Telescope find_files<cr>",
		},
		{
			"<leader>fo",
			"<cmd>Telescope oldfiles<cr>",
		},
		{
			"<leader>fb",
			"<cmd>Telescope buffers<cr>",
		},
		{
			"<leader>fh",
			function () require("telescope.builtin").help_tags() end,
		},
		{
			"<leader>fg",
			"<cmd>Telescope live_grep<cr>"
		},
		{
			"<leader>fG",
			function()
				require("telescope.builtin").live_grep({ search_dirs = { vim.fn.expand("%:p") } })
			end,
		},
		{
			"<leader>fs",
			function()
				require("telescope.builtin").lsp_document_symbols({
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
					},
				})
			end,
		},
		{
			"<c-p>",
			"<cmd>lua require'util.telescope-config'.project_files()<cr>",
		},
		{
			"<leader><c-p>",
			"<cmd>Telescope find_files<cr>",
		},
		{
			"<leader><c-h>",
			"<cmd>Telescope find_files hidden=true<cr>",
		},
	}
}
