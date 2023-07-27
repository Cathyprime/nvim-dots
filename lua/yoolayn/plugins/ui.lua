return {
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
                "  type :help news<Enter>   ->   for help              ",
                "                                                      ",
                "  press <Space>ff          ->   to find files         ",
                "  press <Space>fr          ->   to find recent files  ",
                "  press <Space>gg          ->   to start Neogit       ",
                "                                                      ",
                "                   Have a nice day :)                 ",
            },
            color = "#f7f3f2",
            scratch = true,
            highlights = function()
                local ns = vim.api.nvim_create_namespace("EnterMatch")
                vim.api.nvim_set_hl(ns, "EnterMatch", { fg = "#187df0" })
                vim.api.nvim_set_hl_ns(ns)
                vim.fn.matchadd("EnterMatch", "<Enter>")
            end,
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
        "echasnovski/mini.statusline",
        opts = {
            set_vim_settings = false,
        },
    },
    {
        "echasnovski/mini.indentscope",
        version = false,
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            -- symbol = "▏",
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "Trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            filetype_exclude = {
                "help",
                "Trouble",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
                "lazyterm",
            },
            show_end_of_line = true,
            space_char_blankline = " ",
        },
        config = function(default, opts)
            vim.opt.list = true
            vim.opt.listchars:append("eol:↴")

            local options = vim.tbl_deep_extend("force", default, opts)
            require("indent_blankline").setup(options)
        end,
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
