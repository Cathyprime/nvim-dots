return {
    {
        "folke/noice.nvim",
        dependencies = "MunifTanjim/nui.nvim",
        opts = {},
    },
    {
        "Yoolayn/nvim-intro",
        config = {
            intro = {
                "███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
                "████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
                "██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
                "██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
                "██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
                "╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
                "                      [ @Yoolayn ]                    ",
                "                                                      ",
                "  type :checkhealth<Enter> ->   to optimize Nvim      ",
                "  type :Lazy<Enter>        ->   to update plugins     ",
                "  type :help<Enter>        ->   for help              ",
                "                                                      ",
                "  type :help news<Enter>   ->   to read news          ",
                "                                                      ",
                "  press <Space>ff          ->   to find files         ",
                "  press <Space>fr          ->   to find recent files  ",
                "  press <Space>gg          ->   to start Neogit       ",
                "                                                      ",
                "                   Have a nice day :)                 ",
            },
            color = "#f7f3f2",
            scratch = true,
            highlights = {
                ["<Enter>"] = "#187df0",
            },
        },
    },
    {
        "vigoux/notifier.nvim",
        opts = {
            notify = {
                min_level = vim.log.levels.TRACE,
            },
        },
    },
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
    },
    {
        "JellyApple102/easyread.nvim",
        opts = {
            filetypes = {},
        },
        cmd = "EasyreadToggle",
        keys = {
            {
                "<leader>uR",
                ":EasyreadToggle<CR>",
                desc = "easy read",
            },
        },
        ft = "txt",
    },
}
