vim.g.mapleader = " "
vim.g.localleader = "\\"

SWITCHES = {
    files = false,
    dap = true,
    scala = true,
    go = true,
}

require("cathy.config.options")
require("cathy.minideps")
require("cathy.globals")
