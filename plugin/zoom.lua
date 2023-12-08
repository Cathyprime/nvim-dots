local M = {}

function M.zoom()
	local start, stop, text = M.__get_text()
	M.__create_buf(start, stop, vim.api.nvim_get_current_buf(), text)
end

vim.api.nvim_create_user_command(
	"Zoom",
	function()
		M.zoom()
	end,
	{}
)

function M.__get_text()
	local start = vim.fn.getpos("'<")[2] - 1
	local stop = vim.fn.getpos("'>")[2]
	local lines = vim.api.nvim_buf_get_lines(0, start, stop, true)
	return start, stop, lines
end

function M.__create_buf(start, stop, ogbufnr, text)
	local temp = vim.fn.tempname()
	local buf = vim.api.nvim_create_buf(true, false)
	vim.api.nvim_set_option_value("bufhidden", "unload", { buf = buf })
	vim.api.nvim_set_current_buf(buf)
	vim.cmd.edit(temp)
	M.__set_autocmds(start, stop, ogbufnr, buf)
	vim.api.nvim_buf_set_lines(0, 0, -1, false, text)
end

function M.__set_autocmds(start, stop, ogb, bufnr)
	vim.api.nvim_create_autocmd("BufWritePost", {
		buffer = bufnr,
		once = false,
		callback = function()
			local lines = M.__get_all_lines(bufnr)
			vim.api.nvim_buf_set_lines(ogb, start, stop, true, lines)
			vim.cmd("bw! " .. bufnr)
		end
	})
end

function M.__get_all_lines(bufnr)
	return vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
end

return M
