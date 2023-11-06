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
local cmd_args        = { "run", "lua.c" }
local compiler_output = uv.new_pipe()

vim.api.nvim_buf_set_lines(target, 0, 1, true, { "compilation started with: " .. cmd .. " " .. table.concat(cmd_args, " ") })

local options = {
	args = cmd_args,
	stdio = { nil, compiler_output, nil }
}

local handle
local function on_exit(_)
	uv.read_stop(compiler_output)
	uv.close(compiler_output)
	uv.close(handle)
	print("compilation done")
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
			-- TODO: set cursor to scroll
		end)
	end
end)
