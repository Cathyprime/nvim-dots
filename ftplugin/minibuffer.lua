vim.keymap.set({ "n", "i"}, "<c-g>", "norm :close<cr>", { buffer = true, silent = true })
vim.keymap.set({ "n", "i"}, "<c-c>", "<cmd>close<cr>", { buffer = true, silent = true })
vim.keymap.set({"i"}, "<c-k>", "<up>", { buffer = true, silent = true })
vim.keymap.set({"i"}, "<c-j>", "<down>", { buffer = true, silent = true })
vim.api.nvim_win_set_height(0, 1)
vim.opt_local.spell = false
vim.opt_local.winbar = nil
vim.o.laststatus = 0

local old_height = vim.opt.pumheight
vim.opt.pumheight = 3

vim.api.nvim_create_autocmd("CmdwinLeave", {
	once = false,
	callback = function()
		vim.o.laststatus = 3
		vim.opt.pumheight = old_height
	end
})

local cmp = require("cmp")
---@diagnostic disable-next-line
cmp.setup.buffer({
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "cmdline" },
	}, {
		{ name = "buffer" },
	}, {
		{ name = "nvim_lua" },
	}),

})
