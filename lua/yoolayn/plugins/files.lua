return {
    {
        "stevearc/oil.nvim",
        keys = {
            {
                "<leader>ef",
                function()
                    require("oil").open()
                end,
                desc = "explore files",
            },
        },
        opts = {},
    },
}
