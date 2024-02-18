require("mini.deps").add("rebelot/kanagawa.nvim")

require("mini.deps").now(function()
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
                Whitespace = { bg = "none", fg = "#1e1e28" },
                TelescopeTitle = { fg = theme.ui.special, bg = theme.ui.bg_p1, bold = true, },
                TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = "NONE", },
                TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = "NONE", },
                TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = "NONE", },
                TelescopePreviewBorder = { fg = theme.ui.bg_dim, bg = "NONE", },
                Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
                PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                PmenuSbar = { bg = theme.ui.bg_m1 },
                PmenuThumb = { bg = theme.ui.bg_p2 },
                ["@markup.link.url.markdown_inline"] = { link = "Special" }, -- (url)
                ["@markup.link.label.markdown_inline"] = { link = "Identifier" }, -- [label]
                ["@markup.italic.markdown_inline"] = { link = "Exception" }, -- *italic*
                ["@markup.raw.markdown_inline"] = { link = "String" }, -- `code`
                ["@markup.list.markdown"] = { link = "Function" }, -- + list
            }
        end,
    })
    vim.cmd.colorscheme "kanagawa"
end)

-- {
--     "dasupradyumna/midnight.nvim",
--     -- opts = {},
--     config = function(_, opts)
--         require("midnight").setup(opts)
--         vim.cmd.colorscheme "midnight"
--     end
-- },
