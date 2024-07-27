local icons     = require("util.icons").icons
local lsp_funcs = require("cathy.config.lsp-funcs")

vim.cmd([[sign define DiagnosticSignError text=]] .. icons.Error   .. [[ texthl=DiagnosticSignError linehl= numhl= ]])
vim.cmd([[sign define DiagnosticSignWarn text=]]  .. icons.Warning .. [[ texthl=DiagnosticSignWarn linehl= numhl= ]])
vim.cmd([[sign define DiagnosticSignInfo text=]]  .. "🤓"          .. [[ texthl=DiagnosticSignInfo linehl= numhl= ]])
vim.cmd([[sign define DiagnosticSignHint text=]]  .. icons.Hint    .. [[ texthl=DiagnosticSignHint linehl= numhl= ]])

vim.diagnostic.config({
    -- virtual_text = {
    --     prefix = "⚫︎"
    -- },
    virtual_text = false,
    float = {
        border = "rounded"
    }
})
-- vim.diagnostic.enable(false)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})

local function disabled()
    return true
end

vim.lsp.log.set_level(vim.log.levels.ERROR)

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
        -- "rust_analyzer",
        "tailwindcss",
        "tsserver",
        "yamlls",
    },
    handlers = {
        lsp_funcs.default_setup,
        jdtls = disabled,
        rust_analyzer = disabled,
        -- tsserver = lsp_funcs.tsserver,
        lua_ls = lsp_funcs.lua_ls,
        omnisharp = function()
            require("lspconfig").omnisharp.setup({
                handlers = {
                    ["textDocument/definition"] = require("omnisharp_extended").definition_handler,
                    ["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
                    ["textDocument/references"] = require("omnisharp_extended").references_handler,
                    ["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
                }
            })
        end
    }
})
