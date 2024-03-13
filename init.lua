vim.g.mapleader = " "
vim.g.localleader = "\\"

SWITCHES = {
    files = false,
    dap = true,
    scala = true,
    go = true,
}

pcall(require, "cathy.minideps")
pcall(require, "cathy.globals")
require("cathy.config.options")
