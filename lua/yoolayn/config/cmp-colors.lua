local M = {}

M.groups = {
    "CmpItemKindTypeParameter",
    "CmpItemKindConstructor",
    "CmpItemKindEnumMember",
    "CmpItemKindReference",
    "CmpItemKindInterface",
    "CmpItemKindVariable",
    "CmpItemKindProperty",
    "CmpItemKindOperator",
    "CmpItemKindFunction",
    "CmpItemKindConstant",
    "CmpItemKindSnippet",
    "CmpItemKindKeyword",
    "CmpItemKindCopilot",
    "CmpItemKindStruct",
    "CmpItemKindModule",
    "CmpItemKindMethod",
    "CmpItemKindFolder",
    "CmpItemKindValue",
    "CmpItemKindField",
    "CmpItemkindEvent",
    "CmpItemkindColor",
    "CmpItemKindClass",
    "CmpItemkindUnit",
    "CmpItemKindText",
    "CmpItemKindFile",
    "CmpItemKindEnum",
}

M.opts = {
    log = false,
}

M.darken = function(color, shift)
    M.log("darkening", color)
    local const = 0xfefefe
    color = bit.band(color, const)
    return bit.rshift(color, shift)
end

M.get_colors = function(hl, disable_log)
    if hl == nil then
        return
    end
    if disable_log ~= nil then
        M.log("getting", hl)
    else
        M.log("still working")
    end
    local group = vim.api.nvim_get_hl(0, {name = hl})
    if group["fg"] ~= nil or group["bg"] ~= nil then
        return group
    else
        return M.get_colors(group["link"], true)
    end
end

M.log = function(...)
    if not M.opts.log then
        return
    end
    print(...)
end

M.run = function(log)
    if log ~= nil then
        M.opts.log = log
    end
    for _, group in ipairs(M.groups) do
        M.log(group)
        local original = M.get_colors(group)
        if original == nil then
            if M.opts.log then
                print("error getting", group)
            end
            goto continue
        end
        if vim.g.neovide then
            vim.api.nvim_set_hl(0, group, {
                fg = original.fg,
                bg = M.darken(original.fg, 1),
                standout = true,
            })
        else
            vim.api.nvim_set_hl(0, group, {
                bg = original.fg,
                fg = M.darken(original.fg, 1),
                standout = true,
            })
        end
        ::continue::
    end
end

M.set_autocmd = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
        once = false,
        callback = function()
            M.run()
        end
    })
end

return M
