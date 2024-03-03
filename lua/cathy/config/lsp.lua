local lspconfig = require "lspconfig"
local icons = require("util.icons").icons
local telescope = require("telescope.builtin")

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

local function telescope_references()
    require("telescope.builtin").lsp_references({
        include_declaration = true,
        show_line = true,
        layout_config = {
            preview_width = 0.45,
        }
    })
end

local function on_attach(client, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "<leader>fr", telescope_references,                             opts)
    vim.keymap.set("n", "gI",         require("telescope.builtin").lsp_implementations, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,                          opts)
    vim.keymap.set("n", "<leader>cc", vim.lsp.buf.rename,                               opts)
    vim.keymap.set("i", "<c-h>",      vim.lsp.buf.signature_help,                       opts)
    vim.keymap.set("n", "[d",         vim.diagnostic.goto_prev,                         opts)
    vim.keymap.set("n", "]d",         vim.diagnostic.goto_next,                         opts)
    vim.keymap.set("n", "gd",         vim.lsp.buf.definition,                           opts)
    vim.keymap.set("n", "K",          vim.lsp.buf.hover,                                opts)
    vim.keymap.set("n", "<leader>fs", telescope.lsp_document_symbols,                   opts)
    vim.keymap.set("n", "<leader>fS", telescope.lsp_workspace_symbols,                  opts)

    vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
    if client.server_capabilities.definitionProvider then
        vim.api.nvim_set_option_value("tagfunc", "v:lua.vim.lsp.tagfunc", { buf = bufnr })
    end
end

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local default_setup = function(server)
    lspconfig[server].setup({
        on_attach = on_attach,
    })
end

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "bashls",
        "cssls",
        "emmet_ls",
        "gopls",
        "jsonls",
        "lua_ls",
        "pylsp",
        "rust_analyzer",
        "tailwindcss",
        "tsserver",
        "yamlls",
    },
    handlers = {
        default_setup,
        metals = nil,
        tsserver = function()
            require("lspconfig").tsserver.setup({
                on_attach = on_attach,
                settings = {
                    typescript = {
                        format = {
                            indentSize = vim.o.shiftwidth,
                            convertTabsToSpaces = vim.o.expandtab,
                            tabSize = vim.o.tabstop,
                        },
                    },
                    javascript = {
                        format = {
                            indentSize = vim.o.shiftwidth,
                            convertTabsToSpaces = vim.o.expandtab,
                            tabSize = vim.o.tabstop,
                        },
                    },
                    completions = {
                        completeFunctionCalls = true,
                    },
                }
            })
        end,
        lua_ls = function()
            require("lspconfig").lua_ls.setup({
                on_attach = on_attach,
                on_init = function(client)
                    local path
                    if client.workspace_folders and client.workspace_folders[1] then
                        path = client.workspace_folders[1].name
                    else
                        path = vim.loop.cwd()
                    end
                    if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
                        client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
                            Lua = {
                                runtime = {
                                    version = "LuaJIT",
                                },
                                workspace = {
                                    checkThirdParty = false,
                                    library = (function()
                                        return vim.tbl_deep_extend(
                                            "keep",
                                            {
                                                vim.env.VIMRUNTIME,
                                                "${3rd}/luv/library",
                                                "${3rd}/busted/library",
                                                "$HOME/.config/nvim/lua/",
                                            },
                                            vim.split(vim.fn.glob("$HOME/.local/share/nvim/site/pack/deps/*/*/lua"), "\n")
                                        )
                                    end)(),
                                },
                            },
                        })

                        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                    end
                    return true
                end
            })
        end,
        rust_analyzer = function()
            require("lspconfig").rust_analyzer.setup({
                on_attach = on_attach,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                            loadOutDirsFromCheck = true,
                            runBuildScripts = true,
                        },
                        checkOnSave = {
                            allFeatures = true,
                            command = "clippy",
                            extraArgs = { "--no-deps" },
                        },
                        procMacro = {
                            enable = true,
                            ignored = {
                                ["async-trait"] = { "async_trait" },
                                ["napi-derive"] = { "napi" },
                                ["async-recursion"] = { "async_recursion" },
                            },
                        },
                    },
                },
            })
        end
    }
})

require("mason-tool-installer").setup({
    ensure_installed = {
        "black",
        "eslint",
        "golangci-lint",
        "luacheck",
        "black",
        "stylelint",
        "stylua",
    },
})
