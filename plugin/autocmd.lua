local filetypes = {
	"NvimTree",
	"help",
	"man",
	"TelescopePrompt",
	"toggleterm",
	"NvimTree",
}

local function augroup(name)
	return vim.api.nvim_create_augroup("yoolayn_" .. name, { clear = true })
end

local function chkFiletype(ft)
	for _, value in ipairs(filetypes) do
		if value == ft then
			return true
		end
	end
	return false
end

vim.api.nvim_create_autocmd("CmdwinEnter", {
	once = false,
	callback = function()
		vim.keymap.set({ "n", "i"}, "<c-g>", "norm :close<cr>", { buffer = true, silent = true })
		vim.api.nvim_win_set_height(0, 1)
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

vim.api.nvim_create_autocmd({"VimEnter", "WinEnter"}, {
	once = false,
	callback = function()
		if chkFiletype(vim.bo.filetype) then
			return
		end
		vim.opt_local.cursorline = true
		vim.opt_local.relativenumber = true
	end
})

vim.api.nvim_create_autocmd("WinLeave", {
	once = false,
	callback = function()
		vim.opt_local.cursorline = false
		vim.opt_local.relativenumber = false
	end
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"help",
		"lspinfo",
		"man",
		"fugitive",
		"qf",
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

vim.api.nvim_create_autocmd({"BufRead", "BUfNewFile"}, {
	once = false,
	pattern = {"*.c", "*.h"},
	command = "set ft=c",
})
