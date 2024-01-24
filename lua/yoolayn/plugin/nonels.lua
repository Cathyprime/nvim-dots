return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.eslint_d,
                null_ls.builtins.formatting.gofumpt,
                null_ls.builtins.formatting.prettierd,
                null_ls.builtins.formatting.stylua,

                null_ls.builtins.diagnostics.eslint_d,
                null_ls.builtins.diagnostics.golangci_lint,
                null_ls.builtins.diagnostics.mypy,
                null_ls.builtins.diagnostics.ruff,
                null_ls.builtins.diagnostics.stylelint,

                null_ls.builtins.code_actions.eslint_d,
            },
        })
        vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format)
    end,
}
