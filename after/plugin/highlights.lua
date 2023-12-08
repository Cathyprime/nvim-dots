local augroup = vim.api.nvim_create_augroup("custom_highlight", {})
vim.api.nvim_create_autocmd({"ColorScheme", "VimEnter"}, {
	once = false,
	group = augroup,
	callback = function()
		vim.api.nvim_set_hl(0, "PortalOrange", {
			fg = "#fd6600"
		})
		vim.api.nvim_set_hl(0, "PortalBlue", {
			fg = "#0078ff"
		})
		vim.api.nvim_set_hl(0, "WinSeparator", {
			fg = "#61119e"
		})
		vim.api.nvim_set_hl(0, "Folded", {
			fg = "None"
		})
	end
})
