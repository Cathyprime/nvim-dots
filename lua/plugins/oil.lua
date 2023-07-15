return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
        {
            "<leader>e",
            function()
                require("oil").open()
            end,
            desc = "Oil explorer (cwd)",
        },
    },
}
