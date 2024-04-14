vim.opt_local.expandtab = true
vim.opt_local.include = [[\\v^\\s*(pub\\s+)?use\\s+\\zs(\\f\|:)+]]

vim.g.rustaceanvim = {
    server = {
        on_attach = function(client, bufnr)
            require("cathy.config.lsp-funcs").on_attach(client, bufnr)
            vim.keymap.set("n", "J", "<cmd>RustLsp joinLines<cr>", { silent = true, buffer = true })
            vim.keymap.set("v", "J", ":RustLsp joinLines<cr>", { silent = true, buffer = true })
        end
    }
}
