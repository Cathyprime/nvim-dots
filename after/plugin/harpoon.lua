local ui = require("harpoon.ui")
local mark = require("harpoon.mark")

vim.keymap.set(
	"n",
	"<leader>h",
	function() ui.toggle_quick_menu() end,
	{desc = "harpoon", }
)

vim.keymap.set(
	"n",
	"<leader>a",
	function() mark.add_file() end,
	{desc = "add file", }
)

vim.keymap.set(
	"n",
	"<C-h>f",
	function() ui.nav_file(1) end,
	{desc = "go to first", }
)

vim.keymap.set(
	"n",
	"<C-h>s",
	function() ui.nav_file(2) end,
	{desc = "go to second", }
)

vim.keymap.set(
	"n",
	"<c-h>n",
	function() ui.nav_file(3) end,
	{ desc = "go to next" }
)

vim.keymap.set(
	"n",
	"<c-h>h",
	function() ui.nav_file(4) end,
	{desc = "go to harpoon", }
)
