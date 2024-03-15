vim.g.mapleader = " "
vim.g.localleader = "\\"

SWITCHES = {
    files = false,
    scala = true,
    java = true,
    dap = true,
    go = true,
}

pcall(require, "cathy.minideps")
pcall(require, "cathy.globals")
require("cathy.config.options")
