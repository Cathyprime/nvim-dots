require("mini.deps").add({
    source = "williamboman/mason-lspconfig.nvim",
    depends = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
    },
})

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        require("cathy.config.lsp")
        require("fidget").setup({
            progress = {
                display = {
                    progress_icon = {
                        pattern = "moon",
                        period = 1,
                    },
                },
            },
            notification = {
                window = {
                    winblend = 0,
                    max_width = 60,
                },
            }
        })
    end,
})
