local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        'git', 'clone', '--filter=blob:none',
        -- Uncomment next line to use 'stable' branch
        -- '--branch', 'stable',
        'https://github.com/echasnovski/mini.nvim', mini_path
    }
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.nvim | helptags ALL')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

require("cathy.plugin.mini")

require("cathy.plugin.misc")
require("cathy.plugin.treesitter")
require("cathy.plugin.editing")
require("cathy.plugin.compile")
require("cathy.plugin.git")

require("cathy.plugin.luasnip")
require("cathy.plugin.cmp")
require("cathy.plugin.lsp")
require("cathy.plugin.lsp-misc")
require("cathy.plugin.nonels")

require("cathy.plugin.telescope")
require("cathy.plugin.colorscheme")
require("cathy.plugin.ui")
require("cathy.plugin.quickfix")
require("cathy.plugin.neorg")


if SWITCHES.files == "neotree" then
    require("cathy.plugin.files")
elseif SWITCHES.files == "oil" then
    require("cathy.plugin.oil")
end
if SWITCHES.dap then
    require("cathy.plugin.dap")
end
if SWITCHES.go then
    require("cathy.plugin.gopher")
end
if SWITCHES.java then
    require("cathy.plugin.java")
end
