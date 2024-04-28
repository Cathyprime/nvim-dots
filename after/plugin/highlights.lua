local augroup = vim.api.nvim_create_augroup("custom_highlight", {})

local diagGroups = {
    "DiagnosticFloatingError",
    "DiagnosticFloatingHint",
    "DiagnosticFloatingOk",
    "DiagnosticFloatingWarn",
    "DiagnosticFloatingInfo"
}

vim.api.nvim_create_autocmd({"ColorScheme", "VimEnter"}, {
    once = false,
    group = augroup,
    callback = function()
        vim.api.nvim_set_hl(0, "MiniTrailspace", (function()
            return {
                bg = "#ff5d62",
                fg = "#ff5d62"
            }
        end)()
        )
        vim.api.nvim_set_hl(0, "PortalOrange", {
            fg = "#fd6600"
        })
        vim.api.nvim_set_hl(0, "PortalBlue", {
            fg = "#0078ff"
        })
        vim.api.nvim_set_hl(0, "WinSeparator", {
            fg = "#61119e"
        })
        vim.api.nvim_set_hl(0, "Folded", {
            fg = "None"
        })
        vim.iter(diagGroups):map(function(group)
            if group == "DiagnosticFloatingError" then
                return { name = group, colors = vim.api.nvim_get_hl(0, { name = "DiagnosticError" }) }
            else
                return { name = group, colors = vim.api.nvim_get_hl(0, { name = group }) }
            end
        end)
            :each(function(group)
                vim.api.nvim_set_hl(0, group.name, {
                fg = group.colors.fg
            })
            end)
    end
})
