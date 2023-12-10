local function format()
	local bufnr = vim.api.nvim_get_current_buf()
	local tmp = vim.fn.tempname()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	vim.fn.writefile(lines, tmp)
	vim.system(
		{ "venv/bin/black", tmp },
		{ text = true },
		vim.schedule_wrap(function()
			local formatted = vim.fn.readfile(tmp)
			vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted)
			print("Formatted using black!")
		end)
	)
end

vim.api.nvim_create_autocmd("BufRead", {
	pattern = "*.py",
	callback = function()
		vim.keymap.set(
			"n",
			"<localleader>f",
			format,
			{ buffer = true }
		)
	end
})
