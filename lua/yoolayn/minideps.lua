-- Clone 'mini.deps' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.deps'
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.deps`" | redraw')
    local clone_cmd = {
        'git', 'clone', '--filter=blob:none',
        'https://github.com/echasnovski/mini.deps', mini_path
    }
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.deps | helptags ALL')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

require("yoolayn.plugin.mini")

require("yoolayn.plugin.luasnip")
require("yoolayn.plugin.cmp")
require("yoolayn.plugin.lsp")
require("yoolayn.plugin.lsp-misc")
require("yoolayn.plugin.nonels")

require("yoolayn.plugin.misc")
require("yoolayn.plugin.treesitter")
require("yoolayn.plugin.editing")
require("yoolayn.plugin.compile")
require("yoolayn.plugin.files")
require("yoolayn.plugin.git")

require("yoolayn.plugin.neorg")
require("yoolayn.plugin.lisp")
require("yoolayn.plugin.metals")

require("yoolayn.plugin.telescope")
require("yoolayn.plugin.colorscheme")
require("yoolayn.plugin.ui")
