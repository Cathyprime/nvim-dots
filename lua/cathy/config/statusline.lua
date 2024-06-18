local diff_signs = {
    add = "+",
    change = "~",
    delete = "-",
}

local k = vim.keycode
local CTRL_V = k"<c-v>"
local CTRL_S = k"<c-s>"

vim.api.nvim_set_hl(0, "StatuslineB_insert",            { fg = "#98bb6c", bg = "#252535" })
vim.api.nvim_set_hl(0, "StatuslineB_normal",            { fg = "#7e9cd8", bg = "#252535" })
vim.api.nvim_set_hl(0, "StatuslineB_normal_inactive",   { fg = "#7e9cd8", bg = "#252535" })
vim.api.nvim_set_hl(0, "StatuslineB_visual",            { fg = "#957fb8", bg = "#252535" })
vim.api.nvim_set_hl(0, "StatuslineB_command",           { fg = "#c0a36e", bg = "#252535" })
vim.api.nvim_set_hl(0, "StatuslineB_replace",           { fg = "#ffa066", bg = "#252535" })

vim.api.nvim_set_hl(0, "Statusline_insert",             { fg = "#1f1f28", bg = "#98bb6c" })
vim.api.nvim_set_hl(0, "Statusline_normal",             { fg = "#16161d", bg = "#7e9cd8" })
vim.api.nvim_set_hl(0, "Statusline_normal_inactive",    { fg = "#c8c093", bg = "#7e9cd8" })
vim.api.nvim_set_hl(0, "Statusline_visual",             { fg = "#1f1f28", bg = "#957fb8" })
vim.api.nvim_set_hl(0, "Statusline_command",            { fg = "#1f1f28", bg = "#c0a36e" })
vim.api.nvim_set_hl(0, "Statusline_replace",            { fg = "#1f1f28", bg = "#ffa066" })

vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal",      { fg = "#c8c093", bg = "#571cbd" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeVisual",      { fg = "#181818", bg = "#76946a" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeVisualLine",  { fg = "#c8c093", bg = "#ad410e" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeVisualBlock", { fg = "#80a0ff", bg = "#181818" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeSelect",      { fg = "#003366", bg = "#80a0ff" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert",      { fg = "#181818", bg = "#7e9cd8" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeReplace",     { fg = "#181818", bg = "#ce0406" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand",     { fg = "#181818", bg = "#ffa066" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeOther",       { fg = "#c8c093", bg = "#571cbd" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeTerminal",    { fg = "#e6c384", bg = "#181818" })
vim.api.nvim_set_hl(0, "statusline_register",           { fg = "#16161d", bg = "#7e9cd8" })
vim.api.nvim_set_hl(0, "statusline_register_recording", { fg = "white",   bg = "red"     })
vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo",         { fg = "#7e9cd8", bg = "#252535" })
vim.api.nvim_set_hl(0, "MiniStatuslineDevinfoB",        { fg = "#dcd7ba", bg = "#2a2a37" })

vim.api.nvim_set_hl(0, "StatusDiffAdded",               { fg = "#76946a", bg = "#2a2a37" })
vim.api.nvim_set_hl(0, "StatusDiffChanged",             { fg = "#dca561", bg = "#2a2a37" })
vim.api.nvim_set_hl(0, "StatusDiffDeleted",             { fg = "#c34043", bg = "#2a2a37" })

vim.api.nvim_set_hl(0, "StatusDiagnosticSignError",     { fg = "#e82424", bg = "#2a2a37" })
vim.api.nvim_set_hl(0, "StatusDiagnosticSignWarn",      { fg = "#ff9e3b", bg = "#2a2a37" })
vim.api.nvim_set_hl(0, "StatusDiagnosticSignInfo",      { fg = "#658594", bg = "#2a2a37" })
vim.api.nvim_set_hl(0, "StatusDiagnosticSignHint",      { fg = "#6a9589", bg = "#2a2a37" })

local five_hls = {
    ["n"]       = "Statusline_normal",
    ["no"]      = "Statusline_normal",
    ["nov"]     = "Statusline_normal",
    ["noV"]     = "Statusline_normal",
    ["noCTRL"]  = "Statusline_normal",
    ["CTRL"]    = "Statusline_normal",
    ["niI"]     = "Statusline_normal",
    ["niR"]     = "Statusline_normal",
    ["niV"]     = "Statusline_normal",
    ["nt"]      = "Statusline_normal",
    ["ntT"]     = "Statusline_normal",
    ["v"]       = "Statusline_visual",
    ["vs"]      = "Statusline_visual",
    ["V"]       = "Statusline_visual",
    ["Vs"]      = "Statusline_visual",
    [CTRL_V]  = "Statusline_visual",
    [CTRL_V .. "s"] = "Statusline_visual",
    ["s"]       = "Statusline_visual",
    ["S"]       = "Statusline_visual",
    [CTRL_S]  = "Statusline_visual",
    ["i"]       = "Statusline_insert",
    ["ic"]      = "Statusline_insert",
    ["ix"]      = "Statusline_insert",
    ["R"]       = "Statusline_replace",
    ["Rc"]      = "Statusline_replace",
    ["Rx"]      = "Statusline_replace",
    ["Rv"]      = "Statusline_replace",
    ["Rvc"]     = "Statusline_replace",
    ["Rvx"]     = "Statusline_replace",
    ["c"]       = "Statusline_command",
    ["cr"]      = "Statusline_command",
    ["cv"]      = "Statusline_command",
    ["cvr"]     = "Statusline_command",
    ["r"]       = "Statusline_normal",
    ["rm"]      = "Statusline_normal",
    ["r?"]      = "Statusline_normal",
    ["!"]       = "Statusline_normal",
    ["t"]       = "Statusline_normal",
}

local background_five_hls = {
    ["n"]       = "StatuslineB_normal",
    ["no"]      = "StatuslineB_normal",
    ["nov"]     = "StatuslineB_normal",
    ["noV"]     = "StatuslineB_normal",
    ["noCTRL"]  = "StatuslineB_normal",
    ["CTRL"]    = "StatuslineB_normal",
    ["niI"]     = "StatuslineB_normal",
    ["niR"]     = "StatuslineB_normal",
    ["niV"]     = "StatuslineB_normal",
    ["nt"]      = "StatuslineB_normal",
    ["ntT"]     = "StatuslineB_normal",
    ["v"]       = "StatuslineB_visual",
    ["vs"]      = "StatuslineB_visual",
    ["V"]       = "StatuslineB_visual",
    ["Vs"]      = "StatuslineB_visual",
    [CTRL_V]  = "StatuslineB_visual",
    [CTRL_V .. "s"] = "StatuslineB_visual",
    ["s"]       = "StatuslineB_visual",
    ["S"]       = "StatuslineB_visual",
    [CTRL_S]  = "StatuslineB_visual",
    ["i"]       = "StatuslineB_insert",
    ["ic"]      = "StatuslineB_insert",
    ["ix"]      = "StatuslineB_insert",
    ["R"]       = "StatuslineB_replace",
    ["Rc"]      = "StatuslineB_replace",
    ["Rx"]      = "StatuslineB_replace",
    ["Rv"]      = "StatuslineB_replace",
    ["Rvc"]     = "StatuslineB_replace",
    ["Rvx"]     = "StatuslineB_replace",
    ["c"]       = "StatuslineB_command",
    ["cr"]      = "StatuslineB_command",
    ["cv"]      = "StatuslineB_command",
    ["cvr"]     = "StatuslineB_command",
    ["r"]       = "StatuslineB_normal",
    ["rm"]      = "StatuslineB_normal",
    ["r?"]      = "StatuslineB_normal",
    ["!"]       = "StatuslineB_normal",
    ["t"]       = "StatuslineB_normal",
}

local function five_hl()
    return five_hls[vim.fn.mode()]
end

local function background_five_hl()
    return background_five_hls[vim.fn.mode()]
end

local function get_diff(which)
    if not vim.b.minidiff_summary then
        return ""
    end
    if vim.b.minidiff_summary[which] == 0 or vim.b.minidiff_summary[which] == nil then
        return ""
    end
    return diff_signs[which] .. vim.b.minidiff_summary[which]
end

local function format_element(hl, str)
    if str == "" then
        return ""
    end
    return string.format("%%#%s#%s", hl, str)
end

local function diff_component(args)
    if MiniStatusline.is_truncated(args.trunc_width) then
        return ""
    end

    local space_added = false
    local add = get_diff("add")
    local change = get_diff("change")
    local delete = get_diff("delete")

    if not space_added and add ~= "" then
        add = " " .. add
        space_added = true
    end

    if not space_added and change ~= "" then
        change =  " " .. change
        space_added = true
    end

    if not space_added and delete ~= "" then
        delete = " " .. delete
        space_added = true
    end

    local ret_tbl = {
        format_element("StatusDiffAdded", add),
        format_element("StatusDiffChanged", change),
        format_element("StatusDiffDeleted", delete),
    }

    return vim.iter(ret_tbl):filter(function(elem)
        return elem ~= ""
    end):fold("", function(acc, elem)
        if acc == "" then
            return elem
        end
        return acc .. " " .. elem
    end)
end

local modes = {
    ["n"] = { long = "[ Normal ]", short = "N", hl = "MiniStatuslineModeNormal" },
    ["v"] = { long = "[ Visual ]", short = "V", hl = "MiniStatuslineModeVisual" },
    ["V"] = { long = "[ VisLin ]", short = "V-L", hl = "MiniStatuslineModeVisualLine" },
    [CTRL_V] = { long = "[ VisBlk ]", short = "V-B", hl = "MiniStatuslineModeVisualBlock" },
    ["s"] = { long = "--Select--", short = "S", hl = "MiniStatuslineModeSelect" },
    ["S"] = { long = "--SelLin--", short = "S-L", hl = "MiniStatuslineModeSelect" },
    [CTRL_S] = { long = "--SelBlk--", short = "S-B", hl = "MiniStatuslineModeSelect" },
    ["i"] = { long = "--Insert--", short = "I", hl = "MiniStatuslineModeInsert" },
    ["R"] = { long = "--Replce--", short = "R", hl = "MiniStatuslineModeReplace" },
    ["c"] = { long = "--Cmmand--", short = "C", hl = "MiniStatuslineModeCommand" },
    ["r"] = { long = "--Prompt--", short = "P", hl = "MiniStatuslineModeOther" },
    ["!"] = { long = "--Shell --", short = "Sh", hl = "MiniStatuslineModeOther" },
    ["t"] = { long = "--Termnl--", short = "T", hl = "MiniStatuslineModeTerminal" },
}

local function mode_component(args)
    local mode_info = modes[vim.fn.mode()]
    local mode = MiniStatusline.is_truncated(args.trunc_width) and mode_info.short or mode_info.long
    return mode, mode_info.hl
end

local function cursor_pos_component(args)
    if MiniStatusline.is_truncated(args.trunc_width) then
        return "%l:%c"
    end
    return "(%l:%c)"
end

local function window_component(args)
    if MiniStatusline.is_truncated(args.trunc_width) then
        return ""
    end
    return string.format("[%s:%s]", vim.api.nvim_win_get_number(0), vim.api.nvim_get_current_buf())
end

local function get_hl()
    if vim.fn.reg_recording() ~= "" then
        return "statusline_register_recording"
    else
        return five_hls[vim.fn.mode()]
    end
end


local function recording_component(args)
    local recording = vim.fn.reg_recording()
    if recording ~= "" then
        if not MiniStatusline.is_truncated(args.trunc_width) then
            recording = string.format("   -> %s", recording)
        end
    end
    local register = vim.v.register
    if register == "%" then
        register = "%%"
    end
    return format_element(get_hl(), string.format(" %s%s", register, recording))
end

local function filename_component(args)
    if MiniStatusline.is_truncated(args.trunc_width) then
        return ""
    end
    if vim.bo.buftype == "terminal" then
        return "%t"
    end

    return vim.fn.expand('%:~:.') .. " %m%r"
end

local function last_button_component(args)
    if MiniStatusline.is_truncated(args.trunc_width) then
        return ""
    end
    if vim.fn.mode() == "t" then
        return ""
    else
        return "%S"
    end
end

local diagnostic_is_disabled = function()
    return not vim.diagnostic.is_enabled({ bufnr = 0 })
end

local diagnostic_levels = {
    { name = "ERROR", sign = "E", hl = "StatusDiagnosticSignError" },
    { name = "WARN", sign  = "W", hl = "StatusDiagnosticSignWarn" },
    { name = "INFO", sign  = "I", hl = "StatusDiagnosticSignInfo" },
    { name = "HINT", sign  = "H", hl = "StatusDiagnosticSignHint" },
}

local function diagnostics_component(args)
    if MiniStatusline.is_truncated(args.trunc_width) or diagnostic_is_disabled() then return "" end

    local count = vim.diagnostic.count()
    local severity, signs, t = vim.diagnostic.severity, args.signs or {}, {}
    for _, level in ipairs(diagnostic_levels) do
        local n = count[severity[level.name]] or 0
        if n > 0 then
            local item = format_element(level.hl, string.format("%s:%s", (signs[level.name] or level.sign), n))
            table.insert(t, item)
        end
    end
    if #t == 0 then
        return ""
    end

    return " " .. table.concat(t, " ")
end

local dap_names = {
    ["dapui_breakpoints"] = "DAP Breakpoints",
    ["dapui_watches"] = "DAP Watches",
    ["dapui_console"] = "DAP Console",
    ["dapui_scopes"] = "DAP Scopes",
    ["dapui_stacks"] = "DAP Stacks",
    ["dap-repl"] = "DAP Repl",
}

local function Statusline_normal(active)
    if active then
        return "Statusline_normal"
    else
        return "Statusline_normal_inactive"
    end
end

local function dap_component(active)
    local name = string.format("%s", dap_names[vim.bo.filetype])
    return MiniStatusline.combine_groups({
        { hl = Statusline_normal(active), strings = { name } },
        { hl = "MiniStatuslineDevinfoB", strings = { "%=" } }
    })
end

local function oil()
    local ok, oil = pcall(require, "oil")
    if ok then
        return vim.fn.fnamemodify(oil.get_current_dir(), ":~")
    else
        return ""
    end
end

local filetypes = {
    ["dapui_scopes"] = dap_component,
    ["dapui_breakpoints"] = dap_component,
    ["dapui_stacks"] = dap_component,
    ["dapui_watches"] = dap_component,
    ["dap-repl"] = dap_component,
    ["dapui_console"] = dap_component,
    ["oil"] = function(active)
        return MiniStatusline.combine_groups({
            { hl = Statusline_normal(active), strings = { oil() } },
            { hl = "MiniStatuslineDevinfoB", strings = { "%=" } },
        })
    end,
    ["man"] = function(active)
        local name = vim.fn.bufname():gsub("man://", "")
        return MiniStatusline.combine_groups({
            { hl = Statusline_normal(active), strings = { "MAN" } },
            { hl = "MiniStatuslineDevinfo", strings = { name } },
            { hl = "MiniStatuslineDevinfoB", strings = { "%=" } },
            { hl = "MiniStatuslineDevinfo", strings = { "%P" } },
            { hl = "Statusline_normal", strings = { "%l:%c" } },
        })
    end,
    ["qf"] = function(active)
        return MiniStatusline.combine_groups({
            { hl = Statusline_normal(active), strings = { "%q" } },
            { hl = "MiniStatuslineDevinfoB", strings = { "" }},
            "%=",
            { hl = "Statusline_normal",  strings = { "(%l:%c)" } }
        })
    end,
    ["undotree"] = function(active)
        return MiniStatusline.combine_groups({
            { hl = Statusline_normal(active), strings = { "Undotree" } },
            { hl = "MiniStatuslineDevinfoB", strings = { "" }},
            "%=",
        })
    end,
}

local function choose()
    local ft = vim.bo.filetype
    local ok = vim.iter(filetypes):any(function(filetype)
        return filetype == ft
    end)
    if ok then
        return ok, filetypes[ft]
    end
end

vim.keymap.set({ "n", "x" }, "<leader><cr>", function()
    MiniMisc.put(MiniStatusline.active())
end)

return {
    filetype_specific = choose,
    mode_highlightsB = background_five_hl,
    mode_highlights = five_hl,
    last_button = last_button_component,
    diagnostics = diagnostics_component,
    cursor_pos = cursor_pos_component,
    recording = recording_component,
    filename = filename_component,
    window = window_component,
    mode = mode_component,
    diff = diff_component,
}
