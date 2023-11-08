vim.api.nvim_create_autocmd("CmdwinEnter", {
	once = false,
	callback = function()
		vim.keymap.set({ "n", "i"}, "<c-g>", "<cmd>close<cr>", { buffer = true, silent = true })
		vim.keymap.set({"i"}, "<c-k>", "<up>", { buffer = true, silent = true })
		vim.keymap.set({"i"}, "<c-j>", "<down>", { buffer = true, silent = true })
		vim.api.nvim_win_set_height(0, 1)
		vim.opt.laststatus = 0
		vim.opt_local.pumheight = 3
		vim.opt_local.winbar = nil
		---@diagnostic disable-next-line
		require("cmp").setup.buffer({
			sources = require("cmp").config.sources({
				{ name = "path" },
				{ name = "cmdline" },
			}, {
				{ name = "buffer" },
			}, {
				{ name = "nvim_lua" },
			}),

		})
	end
})

vim.api.nvim_create_autocmd("CmdwinLeave", {
	once = false,
	callback = function()
		vim.opt.laststatus = 3
	end
})
