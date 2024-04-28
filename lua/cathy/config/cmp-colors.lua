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

M.lighten = function(color, shift)
    M.log("lightening", color)
    local const = 0x7f7f7f
    color = bit.band(color, const)
    return bit.lshift(color, shift)
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
    vim.iter(M.groups)
        :map(function(group)
            return { name = group, colors = M.get_colors(group) }
        end)
        :filter(function(group)
            return group["colors"] ~= nil
        end)
        :each(function(group)
            local colorize1 = M.darken
            local colorize2 = function(a, _)
                return a
            end
            if vim.o.background == "light" then
                colorize1 = function(a, _)
                    return a
                end
                colorize2 = M.lighten
            end
            if vim.g.neovide then
                vim.api.nvim_set_hl(0, group.name, {
                    bg = colorize1(group.colors.fg, 1),
                    fg = colorize2(group.colors.fg, 2),
                    standout = true,
                })
            else
                vim.api.nvim_set_hl(0, group.name, {
                    bg = colorize2(group.colors.fg, 1),
                    fg = colorize1(group.colors.fg, 1),
                    standout = true,
                })
            end
        end)
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
