vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "BufNewFile" }, {
    once = true,
    callback = function()
        vim.cmd.packadd("none-ls-extras.nvim")
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.gofumpt,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.stylua,

                null_ls.builtins.diagnostics.golangci_lint,
                null_ls.builtins.diagnostics.stylelint,
            },
        })
        vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format)
    end,
})
