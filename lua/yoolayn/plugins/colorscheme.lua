return {
    {
        "rose-pine/neovim",
        priority = 1000,
        name = "rose-pine",
    },
    {
        "navarasu/onedark.nvim",
        lazy = true,
        opts = { style = "deep" },
    },
    {
        "catppuccin/nvim",
        lazy = true,
        name = "catppuccin",
    },
    {
        "sainnhe/everforest",
        lazy = true,
    },
    {
        "rebelot/kanagawa.nvim",
        opts = {
            transparent = true,
            overrides = function(colors)
                local theme = colors.theme
                return {
                    TelescopeTitle = { fg = theme.ui.special, bold = true },
                    TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                    TelescopePromptBorder = {
                        fg = theme.ui.bg_p1,
                        bg = theme.ui.bg_p1,
                    },
                    TelescopeResultsNormal = {
                        fg = theme.ui.fg_dim,
                        bg = theme.ui.bg_m1,
                    },
                    TelescopeResultsBorder = {
                        fg = theme.ui.bg_m1,
                        bg = theme.ui.bg_m1,
                    },
                    TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                    TelescopePreviewBorder = {
                        bg = theme.ui.bg_dim,
                        fg = theme.ui.bg_dim,
                    },
                }
            end,
        },
        lazy = true,
    },
    {
        "cpea2506/one_monokai.nvim",
        lazy = true,
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = true,
    },
    {
        "AlexvZyl/nordic.nvim",
        lazy = true,
    },
    {
        "folke/tokyonight.nvim",
        opts = {
            transparent = true,
            on_highlights = function(hl, c)
                local prompt = "#2d3149"
                hl.TelescopeNormal = {
                    bg = c.bg_dark,
                    fg = c.fg_dark,
                }
                hl.TelescopeBorder = {
                    bg = c.bg_dark,
                    fg = c.bg_dark,
                }
                hl.TelescopePromptNormal = {
                    bg = prompt,
                }
                hl.TelescopePromptBorder = {
                    bg = prompt,
                    fg = prompt,
                }
                hl.TelescopePromptTitle = {
                    bg = prompt,
                    fg = prompt,
                }
                hl.TelescopePreviewTitle = {
                    bg = c.bg_dark,
                    fg = c.bg_dark,
                }
                hl.TelescopeResultsTitle = {
                    bg = c.bg_dark,
                    fg = c.bg_dark,
                }
            end,
        },
        lazy = true,
    },
    {
        "xero/miasma.nvim",
        lazy = true,
    },
    {
        "lunarvim/Onedarker.nvim",
        lazy = true,
    },
    {
        "marko-cerovac/material.nvim",
        lazy = true,
        opts = {
            plugins = { -- Uncomment the plugins that you use to highlight them
                -- Available plugins:
                -- "dap",
                -- "dashboard",
                -- "gitsigns",
                -- "hop",
                "indent-blankline",
                -- "lspsaga",
                "mini",
                -- "neogit",
                -- "neorg",
                "nvim-cmp",
                -- "nvim-navic",
                -- "nvim-tree",
                "nvim-web-devicons",
                -- "sneak",
                "telescope",
                "trouble",
                -- "which-key",
            },
            disable = {
                colored_cursor = true,
            },
        },
    },
    {
        "NTBBloodbath/doom-one.nvim",
        setup = function()
            -- Add color to cursor
            vim.g.doom_one_cursor_coloring = false
            -- Set :terminal colors
            vim.g.doom_one_terminal_colors = true
            -- Enable italic comments
            vim.g.doom_one_italic_comments = true
            -- Enable TS support
            vim.g.doom_one_enable_treesitter = true
            -- Color whole diagnostic text or only underline
            vim.g.doom_one_diagnostics_text_color = false
            -- Enable transparent background
            vim.g.doom_one_transparent_background = false

            -- Pumblend transparency
            vim.g.doom_one_pumblend_enable = false
            vim.g.doom_one_pumblend_transparency = 20

            -- Plugins integration
            vim.g.doom_one_plugin_neorg = false
            vim.g.doom_one_plugin_barbar = false
            vim.g.doom_one_plugin_telescope = true
            vim.g.doom_one_plugin_neogit = false
            vim.g.doom_one_plugin_nvim_tree = false
            vim.g.doom_one_plugin_dashboard = false
            vim.g.doom_one_plugin_startify = false
            vim.g.doom_one_plugin_whichkey = false
            vim.g.doom_one_plugin_indent_blankline = true
            vim.g.doom_one_plugin_vim_illuminate = false
            vim.g.doom_one_plugin_lspsaga = false
        end,
    },
}
