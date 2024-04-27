local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        "git", "clone", "--filter=blob:none",
        -- Uncomment next line to use 'stable' branch
        -- '--branch', 'stable',
        "https://github.com/echasnovski/mini.nvim", mini_path
    }
    vim.fn.system(clone_cmd)
    vim.cmd("packadd mini.nvim | helptags ALL")
end

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })

require("cathy.plugin.mini")
require("cathy.plugin.colorscheme")

require("cathy.plugin.misc")
require("cathy.plugin.treesitter")
require("cathy.plugin.editing")
require("cathy.plugin.compile")
require("cathy.plugin.git")

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        require("cathy.plugin.telescope")
        require("cathy.plugin.ui")
        require("cathy.plugin.quickfix")
        require("cathy.plugin.neorg")
    end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "BufNewFile" }, {
    once = true,
    callback = function()
        require("cathy.plugin.nonels")
        require("cathy.plugin.lsp")
        require("cathy.plugin.lsp-misc")
        require("cathy.plugin.dap")
    end
})

vim.api.nvim_create_autocmd("InsertEnter", {
    once = true,
    callback = function()
        require("cathy.plugin.cmp")
        require("cathy.plugin.luasnip")
    end,
})

if SWITCHES.rust then
    require("cathy.config.rust")
end

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        if SWITCHES.files == "neotree" then
            require("cathy.plugin.files")
        elseif SWITCHES.files == "oil" then
            require("cathy.plugin.oil")
        end
        require("cathy.plugin.test")
    end,
})
