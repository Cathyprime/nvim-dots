local Util = require("yoolayn.util.funcs")

return {
	"nvim-telescope/telescope.nvim",
	commit = vim.fn.has("nvim-0.9.0") == 0 and "057ee0f8783" or nil,
	cmd = "Telescope",
	dependencies = { "nvim-lua/plenary.nvim" },
	version = false, -- telescope did only one release, so use HEAD for now
	keys = {
		{ "<leader>/", Util.telescope("live_grep"), desc = "Grep (root dir)" },
		{ "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files (root dir)" },
		-- find
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (root dir)" },
		{ "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
		{ "<leader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
		-- search
		{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
		{ "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
		{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
		{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
		{ "<leader>sm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
		{ "<leader>sw", Util.telescope("grep_string"), desc = "Word (root dir)" },
		{ "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
		{ "<leader>uc", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
		{
			"<leader>ss",
			Util.telescope("lsp_document_symbols", {
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
			}),
			desc = "Goto Symbol",
		},
		{
			"<leader>sS",
			Util.telescope("lsp_dynamic_workspace_symbols", {
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
			}),
			desc = "Goto Symbol (Workspace)",
		},
	},
	opts = {
		defaults = {
			prompt_prefix = " ",
			selection_caret = " ",
			mappings = {
				i = {
					["<C-Down>"] = function(...)
						return require("telescope.actions").cycle_history_next(...)
					end,
					["<C-Up>"] = function(...)
						return require("telescope.actions").cycle_history_prev(...)
					end,
					["<C-j>"] = function(...)
						return require("telescope.actions").preview_scrolling_down(...)
					end,
					["<C-k>"] = function(...)
						return require("telescope.actions").preview_scrolling_up(...)
					end,
				},
			},
		},
	},
}
