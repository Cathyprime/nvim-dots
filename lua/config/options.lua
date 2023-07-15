-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.smartindent = true

-- line wrapping
opt.wrap = true

-- search settings
opt.ignorecase = false
opt.smartcase = true
opt.incsearch = true
opt.hls = true
opt.is = true

-- cursor
opt.cursorline = true
opt.guicursor = "i-ci-ve:block"

-- scrolloff
vim.cmd("set scrolloff=10")

-- sql filetyp rebind
vim.cmd("let g:ftplugin_sql_omni_key = '<C-p>'")

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.colorcolumn = "80"

-- backspace
opt.backspace = "indent,eol,start"

-- split windows
opt.splitright = true
opt.splitbelow = true

-- update time
opt.updatetime = 300

-- swap & backup
opt.swapfile = false
opt.writebackup = false
vim.o.backupcopy = "yes"

-- short message
opt.shortmess:append("c")

-- mode
opt.showmode = false

-- no clipboard
opt.clipboard = ""

-- undo
opt.undofile = true
opt.undodir = vim.fn.stdpath("config") .. "/undo"
