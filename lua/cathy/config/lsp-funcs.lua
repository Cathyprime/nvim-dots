local telescope = require("telescope.builtin")
local lspconfig = require("lspconfig")

local function telescope_references()
    require("telescope.builtin").lsp_references({
        include_declaration = true,
        show_line = true,
        layout_config = {
            preview_width = 0.45,
        }
    })
end

local attach = function(client, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "<leader>fr", telescope_references,            opts)
    vim.keymap.set("n", "gI",         telescope.lsp_implementations,   opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,         opts)
    vim.keymap.set("n", "<leader>cr", vim.lsp.codelens.run,            opts)
    vim.keymap.set("n", "<leader>cc", vim.lsp.buf.rename,              opts)
    vim.keymap.set("i", "<c-h>",      vim.lsp.buf.signature_help,      opts)
    vim.keymap.set("n", "[d",         vim.diagnostic.goto_prev,        opts)
    vim.keymap.set("n", "]d",         vim.diagnostic.goto_next,        opts)
    vim.keymap.set("n", "gd",         vim.lsp.buf.definition,          opts)
    vim.keymap.set("n", "K",          vim.lsp.buf.hover,               opts)
    vim.keymap.set("n", "<leader>fs", telescope.lsp_document_symbols,  opts)
    vim.keymap.set("n", "<leader>fS", telescope.lsp_workspace_symbols, opts)

    vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
    if client.server_capabilities.definitionProvider then
        vim.api.nvim_set_option_value("tagfunc", "v:lua.vim.lsp.tagfunc", { buf = bufnr })
    end
    -- omnisharp being stoopid
    if client.name == "omnisharp" then return end
    if client.server_capabilities.codeLensProvider then
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            group = vim.api.nvim_create_augroup("codeLens", { clear = false }),
            buffer = bufnr,
            callback = function()
                vim.lsp.codelens.refresh({ bufnr = bufnr })
            end
        })
    end
end

return {
    on_attach = attach,
    default_setup = function(server)
        lspconfig[server].setup({
            on_attach = attach,
            capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities(),
                lspconfig[server].capabilities or {}
            )
        })
    end,
    lua_ls = function()
        require("lspconfig").lua_ls.setup({
            on_attach = attach,
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
    tsserver = function()
        require("lspconfig").tsserver.setup({
            on_attach = attach,
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
}
