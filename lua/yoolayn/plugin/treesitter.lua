return {
    "nvim-treesitter/nvim-treesitter",
    event = {"BufNewFile", "BufReadPost", "InsertEnter" },
    build = ":TSUpdate",
    cmd = { "TSUpdate", "TSUpdateSync", "TSToggle" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        {
            "JoosepAlviste/nvim-ts-context-commentstring",
            lazy = true,
            opts = {
                enable_autocmd = false,
            },
        }
    },
    config = function()
        require("yoolayn.config.treesitter")
    end
}
