return {
    "nvim-treesitter/nvim-treesitter",
    event = {"BufNewFile", "BufReadPost", "InsertEnter" },
    build = ":TSUpdate",
    cmd = { "TSUpdate", "TSUpdateSync", "TSToggle" },
    -- commit = "07c8c3d84f67b1530f636dcad31971f569a3df5f",
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
