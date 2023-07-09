return {
    "folke/noice.nvim",
    config = function()
        require("noice").setup({
            cmdline = {
                view = "cmdline",
                format = {
                    search_down = {
                        view = "cmdline",
                    },
                    search_up = {
                        view = "cmdline",
                    },
                },
            },
        })
    end,
}
