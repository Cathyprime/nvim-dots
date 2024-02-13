local augroup = vim.api.nvim_create_augroup("custom_highlight", {})

local diagGroups = {
    "DiagnosticFloatingError",
    "DiagnosticFloatingHint",
    "DiagnosticFloatingOk",
    "DiagnosticFloatingWarn",
    "DiagnosticFloatingInfo"
}

local function get_id()
    for _, match in ipairs(vim.fn.getmatches()) do
        if match.group == "TrailingWhitespace" then return match.id end
    end
end

vim.api.nvim_create_autocmd("InsertEnter", {
    once = false,
    callback = function()
        pcall(vim.fn.matchdelete, get_id())
    end
})

vim.api.nvim_create_autocmd("InsertLeave", {
    once = false,
    callback = function()
        if get_id() ~= nil then return end
        vim.fn.matchadd("TrailingWhitespace", [[\s\+$]])
    end
})

vim.api.nvim_create_autocmd({"ColorScheme", "VimEnter"}, {
    once = false,
    group = augroup,
    callback = function()
        vim.api.nvim_set_hl(0, "TrailingWhitespace", {
            bg = (function()
                local color = vim.api.nvim_get_hl(0, { name = "@keyword.return" })
                print(vim.inspect(color))
                return color.fg
            end)()
        })
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
