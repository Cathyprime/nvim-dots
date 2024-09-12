vim.g.mapleader = " "
vim.g.localleader = [[\]]
vim.o.background = "light"
vim.cmd[[packadd termdebug]]

pcall(require, "cathy.lazy")
pcall(require, "cathy.globals")
require("cathy.config.options")
