require("mini.deps").add("nvimtools/none-ls.nvim")

require("mini.deps").later(function()
    local null_ls = require("null-ls")
    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.gofumpt,
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.google_java_format,

            null_ls.builtins.diagnostics.golangci_lint,
            null_ls.builtins.diagnostics.stylelint,
            require("none-ls.diagnostics.eslint_d"),
        },
    })
    vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format)
end)
