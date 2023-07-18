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

-- sql filetype rebind
vim.cmd("let g:ftplugin_sql_omni_key = '<C-p>'")

-- appearance
opt.termguicolors = true
opt.signcolumn = "yes"
-- opt.colorcolumn = "80"

-- incremental substitute
opt.inccommand = "nosplit"

-- backspace
opt.backspace = "indent,eol,start"

-- split windows
opt.splitright = true
opt.splitbelow = true

-- update time
opt.updatetime = 50

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- no clipboard
opt.clipboard = ""

-- swap & backup
opt.swapfile = false
opt.writebackup = false
vim.o.backupcopy = "yes"

-- short message
opt.shortmess:append("c")
opt.shortmess:append("I")

-- mode
opt.showmode = false

-- no clipboard
opt.clipboard = ""

-- undo
opt.undofile = true
opt.undodir = vim.fn.stdpath("config") .. "/undo"

-- Command-line completion mode
opt.wildmode = "longest:full,full"

-- Minimum window width
opt.winminwidth = 5

-- Disable line wrap
opt.wrap = false

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
