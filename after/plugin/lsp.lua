vim.api.nvim_create_autocmd({"BufRead", "BufNew"}, {
	once = true,
	callback = function()
		require("yoolayn.lsp")
	end
})
