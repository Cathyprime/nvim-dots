local uv = vim.loop

local user_win = vim.api.nvim_get_current_win()
vim.cmd[[new]]
local compile_win = vim.api.nvim_get_current_win()

local target = vim.api.nvim_win_get_buf(compile_win)

vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = target })
vim.api.nvim_set_option_value("buftype", "nofile", { buf = target })
vim.api.nvim_set_option_value("filetype", "compile_mode", { buf = target })
vim.api.nvim_set_option_value("spell", false, { buf = target })
vim.api.nvim_set_option_value("swapfile", false, { buf = target })
vim.api.nvim_set_current_win(user_win)
vim.api.nvim_win_set_height(compile_win, 4)
vim.api.nvim_buf_set_name(target, "compilation-mode")

local cmd             = "lua/compile-mode/compiler"
local cmd_args        = { "run", "lua/compile-mode/lua.c" }
local compiler_output = uv.new_pipe()
local compiler_err    = uv.new_pipe()
local err_lines       = {}

local function err_buf(target_win)
	local err = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = err })
	vim.api.nvim_set_option_value("buftype", "nofile", { buf = err })
	vim.api.nvim_set_option_value("filetype", "compile_mode", { buf = err })
	vim.api.nvim_set_option_value("spell", false, { buf = err })
	vim.api.nvim_set_option_value("swapfile", false, { buf = err })
	vim.api.nvim_buf_set_name(err, "compilation-mode-err")
	vim.api.nvim_buf_set_lines(err, 0, 1, true, { "there were errors :c" })
	for _, value in ipairs(err_lines) do
		vim.api.nvim_buf_set_lines(err, -1, -1, true, {value})
	end
	vim.api.nvim_win_set_buf(target_win, err)
end

vim.api.nvim_buf_set_lines(target, 0, 1, true, { "compilation started with: " .. cmd .. " " .. table.concat(cmd_args, " ") })

local options = {
	args = cmd_args,
	stdio = { nil, compiler_output, compiler_err }
}

local handle
local function on_exit(_)
	uv.read_stop(compiler_output)
	uv.close(compiler_output)
	uv.close(handle)
	if err_lines[1] == nil or err_lines[1] == "" then
		print("compilation done")
		return
	end
	vim.schedule(function()
		err_buf(compile_win)
		print("compilation done with errors")
	end)
end

handle = uv.spawn(cmd, options, on_exit)
uv.read_start(compiler_output, function(_, data)
	if data then
		vim.schedule(function()
			local table = vim.split(data, "\n")
			if table[1] == "" then
				return
			end
			vim.api.nvim_buf_set_lines(target, -1, -1, true, {table[1]})
			vim.api.nvim_win_set_cursor(compile_win, { vim.api.nvim_buf_line_count(target), 0 })
		end)
	end
end)

uv.read_start(compiler_err, function(_, data)
	table.insert(err_lines, data)
end)
