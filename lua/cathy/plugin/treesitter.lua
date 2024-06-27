
return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/nvim-treesitter-context",
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    build = ":TSUpdate",
    config = function()
        require("cathy.config.treesitter")
        ---@diagnostic disable-next-line
        require("ts_context_commentstring").setup({ enable_autocmd = false })
    end
}
