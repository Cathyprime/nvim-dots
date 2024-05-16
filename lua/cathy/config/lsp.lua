local icons     = require("util.icons").icons
local lsp_funcs = require("cathy.config.lsp-funcs")

vim.cmd([[sign define DiagnosticSignError text=]] .. icons.Error   .. [[ texthl=DiagnosticSignError linehl= numhl= ]])
vim.cmd([[sign define DiagnosticSignWarn text=]]  .. icons.Warning .. [[ texthl=DiagnosticSignWarn linehl= numhl= ]])
vim.cmd([[sign define DiagnosticSignInfo text=]]  .. "🤓"          .. [[ texthl=DiagnosticSignInfo linehl= numhl= ]])
vim.cmd([[sign define DiagnosticSignHint text=]]  .. icons.Hint    .. [[ texthl=DiagnosticSignHint linehl= numhl= ]])

vim.diagnostic.config({
    virtual_text = {
        prefix = "⚫︎"
    },
    float = {
        border = "rounded"
    }
})

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

local settings = function(server_name)
    return function()
        require("lspconfig")[server_name].setup({
            on_attach = lsp_funcs.on_attach,
            settings = {
                [server_name] = {
                    codelenses = {
                        gc_details = true,
                        generate = true,
                        regenerate_cgo = false,
                        run_govulncheck = false,
                        test = true,
                        tidy = true,
                        upgrade_dependency = false,
                        vendor = false,
                    }
                }
            }
        })
    end
end

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
        gopls = settings("gopls"),
        templ = settings("templ"),
    }
})
