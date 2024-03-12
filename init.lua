vim.g.mapleader = " "
vim.g.localleader = "\\"

SWITCHES = {
    files = false,
    dap = true,
}

require("cathy.config.options")
require("cathy.minideps")
require("cathy.globals")
