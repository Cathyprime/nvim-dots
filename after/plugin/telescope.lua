local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
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

vim.keymap.set(
	"n",
	"<leader>ff",
	"<cmd>Telescope find_files<cr>",
	{ desc = "find files" }
)

vim.keymap.set(
	"n",
	"<leader>fo",
	"<cmd>Telescope oldfiles<cr>",
	{ desc = "find recent files" }
)

vim.keymap.set(
	"n",
	"<leader>fp",
	function() builtin.builtin() end,
	{desc = "find pickers" }
)

vim.keymap.set(
	"n",
	"<leader>fb",
	"<cmd>Telescope buffers<cr>",
	{desc = "find Buffers" }
)

vim.keymap.set(
	"n",
	"<leader>fh",
	function () builtin.help_tags() end,
	{desc = "vertical help tags" }
)


vim.keymap.set(
	"n",
	"<leader>fg",
	"<cmd>Telescope live_grep<cr>",
	{desc = "live grep" }
)

vim.keymap.set(
	"n",
	"<leader>fG",
	function()
		builtin.live_grep({ search_dirs = { vim.fn.expand("%:p") } })
	end,
	{desc = "live grep current file" }
)


vim.keymap.set(
	"n",
	"<leader>fk",
	"<cmd>Telescope keymaps<cr>",
	{desc = "find keymaps" }
)

vim.keymap.set(
	"n",
	"<leader>fm",
	"<cmd>Telescope marks<cr>",
	{desc = "find marks" }
)

vim.keymap.set(
	"n",
	"<leader>fs",
	function()
		builtin.lsp_document_symbols({
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
	{desc = "find symbols"}
)

-- git
vim.keymap.set(
	"n",
	"<c-p>",
	"<cmd>lua require'util.telescope-config'.project_files()<cr>",
	{desc = "find git files/fallback to find files" }
)

vim.keymap.set(
	"n",
	"<leader><c-p>",
	"<cmd>Telescope find_files<cr>",
	{desc = "find git files/fallback to find files" }
)

vim.keymap.set(
	"n",
	"<leader><c-h>",
	"<cmd>Telescope find_files hidden=true<cr>",
	{desc = "find git files/fallback to find files" }
)
