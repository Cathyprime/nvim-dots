local icons     = require("util.icons").icons
local lsp_funcs = require("cathy.config.lsp-funcs")

vim.cmd([[sign define DiagnosticSignError text=]] .. icons.Error   .. [[ texthl=DiagnosticSignError linehl= numhl= ]])
vim.cmd([[sign define DiagnosticSignWarn text=]]  .. icons.Warning .. [[ texthl=DiagnosticSignWarn linehl= numhl= ]])
vim.cmd([[sign define DiagnosticSignInfo text=]]  .. "🤓"          .. [[ texthl=DiagnosticSignInfo linehl= numhl= ]])
vim.cmd([[sign define DiagnosticSignHint text=]]  .. icons.Hint    .. [[ texthl=DiagnosticSignHint linehl= numhl= ]])

vim.diagnostic.config({
    virtual_text = {
        prefix = "⚫︎"
    }
})

local border = {
    {"🭽", "FloatBorder"},
    {"▔", "FloatBorder"},
    {"🭾", "FloatBorder"},
    {"▕", "FloatBorder"},
    {"🭿", "FloatBorder"},
    {"▁", "FloatBorder"},
    {"🭼", "FloatBorder"},
    {"▏", "FloatBorder"},
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local function disabled()
    return true
end

vim.lsp.log.set_level(vim.log.levels.ERROR)
require("mini.deps").add("folke/neodev.nvim")
require("neodev").setup()

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "bashls",
        "cssls",
        "emmet_ls",
        "gopls",
        "jdtls",
        "jsonls",
        "lua_ls",
        "pylsp",
        "rust_analyzer",
        "tailwindcss",
        "tsserver",
        "yamlls",
    },
    handlers = {
        lsp_funcs.default_setup,
        jdtls = disabled,
        rust_analyzer = disabled,
        -- tsserver = lsp_funcs.tsserver,
        -- lua_ls = lsp_funcs.lua_ls,
    }
})
