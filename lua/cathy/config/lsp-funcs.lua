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

local attach = function(client, bufnr, alt_keys)
    local opts = { buffer = bufnr }
    local frop = vim.tbl_deep_extend("force", { desc = "references" }, opts)
    local fsop = vim.tbl_deep_extend("force", { desc = "document symbols" }, opts)
    local fSop = vim.tbl_deep_extend("force", { desc = "workspace symbols" }, opts)
    local dops = vim.tbl_deep_extend("force", { desc = "Next diagnostics" }, opts)
    local Dops = vim.tbl_deep_extend("force", { desc = "Prev diagnostics" }, opts)
    local old_goto_prev = function()
        vim.diagnostic.goto_prev({ severity = { min = vim.diagnostic.severity.HINT } })
    end
    local old_goto_next = function()
        vim.diagnostic.goto_next({ severity = { min = vim.diagnostic.severity.HINT } })
    end
    vim.keymap.set("n", "<leader>fr", alt_keys and alt_keys.telescope_references  or telescope_references,            frop)
    vim.keymap.set("n", "gI",         alt_keys and alt_keys.lsp_implementations   or telescope.lsp_implementations,   opts)
    vim.keymap.set("n", "<leader>ca", alt_keys and alt_keys.code_action           or vim.lsp.buf.code_action,         opts)
    vim.keymap.set("n", "<leader>cr", alt_keys and alt_keys.codelens_run          or vim.lsp.codelens.run,            opts)
    vim.keymap.set("n", "<leader>cc", alt_keys and alt_keys.rename                or vim.lsp.buf.rename,              opts)
    vim.keymap.set("i", "<c-h>",      alt_keys and alt_keys.signature_help        or vim.lsp.buf.signature_help,      opts)
    vim.keymap.set("n", "<c-h>",      alt_keys and alt_keys.signature_help        or vim.lsp.buf.signature_help,      opts)
    vim.keymap.set("n", "]d",         alt_keys and alt_keys.diagnostic_goto_next  or old_goto_next,                   dops)
    vim.keymap.set("n", "[d",         alt_keys and alt_keys.diagnostic_goto_prev  or old_goto_prev,                   Dops)
    vim.keymap.set("n", "gd",         alt_keys and alt_keys.definition            or vim.lsp.buf.definition,          opts)
    vim.keymap.set("n", "K",          alt_keys and alt_keys.hover                 or vim.lsp.buf.hover,               opts)
    vim.keymap.set("n", "<leader>fs", alt_keys and alt_keys.lsp_document_symbols  or telescope.lsp_document_symbols,  fsop)
    vim.keymap.set("n", "<leader>fS", alt_keys and alt_keys.lsp_workspace_symbols or telescope.lsp_workspace_symbols, fSop)

    vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
    if client.server_capabilities.definitionProvider then
        vim.api.nvim_set_option_value("tagfunc", "v:lua.vim.lsp.tagfunc", { buf = bufnr })
    end

    -- they are being stoopid with code lenses
    local is_stoopid = function(elem)
        return client.name == elem
    end
    if vim.iter({ "omnisharp", "gopls", "templ" }):any(is_stoopid) then
        if client.server_capabilities.codeLensProvider then
            vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
                group = vim.api.nvim_create_augroup("code_lens", { clear = false }),
                buffer = bufnr,
                callback = function()
                    vim.lsp.codelens.refresh({ bufnr = bufnr })
                end
            })
        end
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
                (function()
                    local ok, cmp = pcall(require, "cmp_nvim_lsp")
                    if ok then
                        return cmp.default_capabilities()
                    else
                        return {}
                    end
                end)(),
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
                if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
                    return
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        version = 'LuaJIT'
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
                                    vim.g.rocks_nvim.rocks_path .. "/share/lua/5.1/",
                                },
                                vim.split(vim.fn.glob("$HOME/.local/share/nvim/site/pack/deps/*/*/lua"), "\n")
                            )
                        end)(),
                    }
                })
                client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
            end,
            settings = {
                Lua = {}
            }
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
