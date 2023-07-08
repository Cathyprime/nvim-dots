return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup()
    end,
    keys = {
        {
            "<leader>e",
            function()
                require("oil").open()
            end,
            desc = "Oil explorer (cwd)",
        },
        {
            "<leader>.",
            function()
                require("oil").toggle_float()
            end,
            desc = "Oil Floating (cwd)",
        },
    },
}
