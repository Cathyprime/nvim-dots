require("config.options")
require("config.keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins.lsp" },
		{ import = "plugins.coding" },
		{ import = "plugins.coding.langs" },
		{ import = "plugins.editor" },
		{ import = "plugins.ui" },
		{ import = "plugins.util" },
		{ import = "colorschemes" },
	},
})

require("config.colorscheme")
