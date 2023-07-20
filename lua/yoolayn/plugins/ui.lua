return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        event = "VeryLazy",
        opts = {
            options = {
                globalstatus = true,
            },
            sections = {
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                    },
                },
            },
        },
    },
    {
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
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
                    "alpha",
                    "dashboard",
                    "neo-tree",
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
                "alpha",
                "dashboard",
                "neo-tree",
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
    },
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        event = "VeryLazy",
        config = function()
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            any = {
                                { find = "%d+L, %d+B" },
                                { find = "; after #%d+" },
                                { find = "; before #%d+" },
                            },
                        },
                        view = "mini",
                    },
                },
                presets = {
                    bottom_search = true,
                    long_message_to_split = true,
                    inc_rename = true,
                },
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
		-- stylua: ignore
		keys = {
			{ "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
			{ "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
			{ "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
			{ "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
			{ "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
			{ "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
			{ "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
		},
    },
    {
        "anuvyklack/help-vsplit.nvim",
        opts = {},
    },
    {
        "JellyApple102/easyread.nvim",
        opts = {
            filetypes = {},
        },
        cmd = "EasyreadToggle",
        keys = {
            {
                "<leader>ur",
                ":EasyreadToggle<CR>",
                desc = "Bionic Reading",
            },
        },
        ft = "txt",
    },
}
