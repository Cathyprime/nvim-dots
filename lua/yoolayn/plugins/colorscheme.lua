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
