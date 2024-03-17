local telescope = require("telescope.builtin")

local function telescope_references()
    require("telescope.builtin").lsp_references({
        include_declaration = true,
        show_line = true,
        layout_config = {
            preview_width = 0.45,
        }
    })
end

return {
    on_attach = function(client, bufnr)
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
    end
}
