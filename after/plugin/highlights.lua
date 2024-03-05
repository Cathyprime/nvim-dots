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
            local color = vim.api.nvim_get_hl(0, { name = "@keyword.return" })
            return {
                bg = color.fg,
                fg = color.fg
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
        for _, group in ipairs(diagGroups) do
            local old
            if group == "DiagnosticFloatingError" then
                old = vim.api.nvim_get_hl(0, { name = "DiagnosticError" })
            else
                old = vim.api.nvim_get_hl(0, { name = group })
            end
            vim.api.nvim_set_hl(0, group, {
                fg = old.fg
            })
        end
    end
})
