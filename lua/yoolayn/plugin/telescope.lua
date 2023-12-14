return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
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
					},
				},
			},
			pickers = {
				buffers = {
					mappings = {
						i = {
							["<c-d>"] = "delete_buffer"
						}
					}
				}
			}
		})
	end,
	keys = {
		{
			"<leader>ff",
			function() require("telescope.builtin").find_files({
				file_ignore_patterns = {
					"node%_modules/*",
					"venv/*",
					"%.git/*"
				},
				hidden = true,
				theme = "dropdown"
			}) end
		},
		{
			"<leader>fF",
			require("telescope.builtin").resume
		},
		{
			"<leader>fo",
			function() require("telescope.builtin").oldfiles() end
		},
		{
			"<leader>fb",
			function() require("telescope.builtin").buffers() end
		},
		{
			"<leader>fh",
			function() require("telescope.builtin").help_tags() end,
		},
		{
			"<leader>fg",
			function() require("telescope.builtin").live_grep() end
		},
		{
			"<leader>fp",
			require("util.telescope-config").change_dir,
		},
		{
			"<leader>fG",
			function()
				require("telescope.builtin").live_grep({
					search_dirs = { vim.fn.expand("%:p") }
				})
			end,
		},
		{
			"<leader>gs",
			require("telescope.builtin").git_status,
		},
		{
			"<c-p>",
			function() require("util.telescope-config").project_files() end
		},
	}
}
