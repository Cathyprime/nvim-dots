return {
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("kanagawa").setup({
                transparent = false,
                colors = {
                    theme = {
                        all = { ui = { bg_gutter = "none" } },
                    },
                },
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        Normal = { bg = "#16161d" },
                        Whitespace = {
                            bg = "none",
                            fg = "#1e1e28"
                        },
                        TelescopeTitle = {
                            fg = theme.ui.special,
                            bg = theme.ui.bg_p1,
                            bold = true,
                        },
                        TelescopePromptBorder = {
                            fg = theme.ui.bg_p1,
                            bg = "NONE",
                        },
                        TelescopeResultsNormal = {
                            fg = theme.ui.fg_dim,
                            bg = "NONE",
                        },
                        TelescopeResultsBorder = {
                            fg = theme.ui.bg_m1,
                            bg = "NONE",
                        },
                        ["@diff.plus.diff"] = {
                            fg = theme.vcs.added
                        },
                        ["@diff.minus.diff"] = {
                            fg = theme.vcs.removed
                        },
                        ["@variable.parameter.gitcommit"] = {
                            link = "@parameter",
                        },
                        ["@markup.heading.gitcommit"] = {
                            link = "Function",
                        },
                        TelescopePreviewBorder = {
                            fg = theme.ui.bg_dim,
                            bg = "NONE",
                        },
                        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
                        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                        PmenuSbar = { bg = theme.ui.bg_m1 },
                        PmenuThumb = { bg = theme.ui.bg_p2 },
                    }
                end,
            })
            vim.cmd.colorscheme "kanagawa"
        end
    },
    -- {
    --     "dasupradyumna/midnight.nvim",
    --     -- opts = {},
    --     config = function(_, opts)
    --         require("midnight").setup(opts)
    --         vim.cmd.colorscheme "midnight"
    --     end
    -- },
}
