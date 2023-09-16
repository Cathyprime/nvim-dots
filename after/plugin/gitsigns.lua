require("gitsigns").setup({
    on_attach = function(bufnr)
        vim.keymap.set(
        { "o", "x" },
        "ih",
        ":<C-u>Gitsigns select_hunk<cr>",
        {
            desc = "inner hunk",
            buffer = bufnr
        })
    end,
})
