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

require("cathy.plugin.mini")

require("cathy.plugin.luasnip")
require("cathy.plugin.cmp")
require("cathy.plugin.lsp")
require("cathy.plugin.lsp-misc")
require("cathy.plugin.nonels")

require("cathy.plugin.misc")
require("cathy.plugin.treesitter")
require("cathy.plugin.editing")
require("cathy.plugin.compile")
require("cathy.plugin.files")
require("cathy.plugin.git")

---@diagnostic disable-next-line
require("cathy.plugin.telescope")
require("cathy.plugin.colorscheme")
require("cathy.plugin.ui")
require("cathy.plugin.quickfix")

require("cathy.plugin.neorg")
require("cathy.plugin.golang")
require("cathy.plugin.metals")
