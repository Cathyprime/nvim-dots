return {
    -- {
    --     "vigoux/notifier.nvim",
    --     opts = {
    --         notify = {
    --             min_level = 0,
    --         },
    --     },
    -- },
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
