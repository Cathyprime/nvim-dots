vim.g.mapleader = " "
vim.g.localleader = [[\]]
vim.o.background = "light"
vim.cmd[[packadd termdebug]]

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "cathy.plugin" },
    },
    install = { colorscheme = { "habamax" } },
    checker = { enabled = false },
})
