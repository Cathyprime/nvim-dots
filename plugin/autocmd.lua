local function augroup(name)
	return vim.api.nvim_create_augroup("yoolayn_" .. name, { clear = true })
end

-- start minibuffer
vim.api.nvim_create_autocmd("CmdwinEnter", {
	once = false,
	callback = function()
		vim.o.laststatus = 0
		vim.opt_local.filetype = "minibuffer"
	end
})

-- save folds
local save_fold = augroup("Persistent Folds")
vim.api.nvim_create_autocmd("BufWinLeave", {
	pattern = "*.*",
	callback = function() vim.cmd.mkview() end,
	group = save_fold,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*.*",
	callback = function() vim.cmd.loadview({ mods = { emsg_silent = true } }) end,
	group = save_fold,
})

-- terminal settings
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.spell = false
	end
})

-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- close with q
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"help",
		"lspinfo",
		"man",
		"tsplayground",
		"checkhealth",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set(
			"n",
			"q",
			"<cmd>close<cr>",
			{ buffer = event.buf, silent = true }
		)
	end,
})

-- create folder in-between
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- set filetype c for header and .c files instead of c++
vim.api.nvim_create_autocmd({"BufRead", "BUfNewFile"}, {
	once = false,
	pattern = {"*.c", "*.h"},
	command = "set ft=c",
})
