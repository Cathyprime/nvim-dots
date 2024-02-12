require("mini.deps").add({
    source = "nvim-treesitter/nvim-treesitter",
    depends = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/nvim-treesitter-context",
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    hooks = {
        post_checkout = function()
            vim.cmd("TSUpdate")
        end
    }
})
require("yoolayn.config.treesitter")

---@diagnostic disable-next-line
require("ts_context_commentstring").setup({ enable_autocmd = false })
