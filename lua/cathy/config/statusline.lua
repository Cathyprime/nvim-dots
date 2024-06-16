local diff_signs = {
    add = "+",
    change = "~",
    delete = "-",
}

vim.api.nvim_set_hl(0, "Statusline_insert", { fg="#1f1f28", bg="#98bb6c" })
vim.api.nvim_set_hl(0, "Statusline_normal", { fg="#16161d", bg="#7e9cd8" })
vim.api.nvim_set_hl(0, "Statusline_visual", { fg="#1f1f28", bg="#957fb8" })
vim.api.nvim_set_hl(0, "Statusline_command", { fg="#1f1f28", bg="#c0a36e" })
vim.api.nvim_set_hl(0, "Statusline_replace", { fg="#1f1f28", bg="#ffa066" })

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
    ["CTRL-V"]  = "Statusline_visual",
    ["CTRL-Vs"] = "Statusline_visual",
    ["s"]       = "Statusline_visual",
    ["S"]       = "Statusline_visual",
    ["CTRL-S"]  = "Statusline_visual",
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

local function five_hl()
    return five_hls[vim.fn.mode()]
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
    return table.concat({
        format_element("MiniDiffSignAdd", get_diff("add")),
        format_element("MiniDiffSignChange", get_diff("change")),
        format_element("MiniDiffSignDelete", get_diff("delete")),
    }, " ")
end

local k = vim.keycode
local CTRL_V = k("<c-v>")
local CTRL_S = k("<c-s>")

-- ["normal"] = { bg = "#571cbd", fg = "#c8c093" },
-- ["visual"] = { bg = "#76946a", fg = "#181818" },
-- ["vislin"] = { bg = "#ad410e", fg = "#c8c093" },
-- ["visblk"] = { bg = "#181818", fg = "#80a0ff" },
-- ["oppend"] = { bg = "#e6c384", fg = "#181818" },
-- ["select"] = { bg = "#80a0ff", fg = "#003366" },
-- ["sellin"] = { bg = "#80a0ff", fg = "#003366" },
-- ["selblk"] = { bg = "#80a0ff", fg = "#003366" },
-- ["insert"] = { bg = "#7e9cd8", fg = "#181818" },
-- ["replce"] = { bg = "#ce0406", fg = "#181818" },
-- ["replin"] = { bg = "#ce0406", fg = "#181818" },
-- ["cmmand"] = { bg = "#ffa066", fg = "#181818" },
-- ["termnl"] = { bg = "#181818", fg = "#e6c384" },
-- ["confrm"] = { bg = "#571cbd", fg = "#c8c093" },
-- ["unknwn"] = { bg = "black", fg = "white" },

vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { bg = "#571cbd", fg = "#c8c093" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeVisual", { bg = "#76946a", fg = "#181818" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeVisualLine", { bg = "#ad410e", fg = "#c8c093" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeVisualBlock", { bg = "#181818", fg = "#80a0ff" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeSelect", { bg = "#80a0ff", fg = "#003366" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert", { bg = "#7e9cd8", fg = "#181818" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeReplace", { bg = "#ce0406", fg = "#181818" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { bg = "#ffa066", fg = "#181818" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeOther", { bg = "#571cbd", fg = "#c8c093" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeTerminal", { bg = "#181818", fg = "#e6c384" })

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

vim.api.nvim_set_hl(0, "statusline_register", {
    bg = "#7e9cd8",
    fg = "#16161d",
})

vim.api.nvim_set_hl(0, "statusline_register_recording", {
    bg = "red",
    fg = "white"
})

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
    return format_element(get_hl(), string.format(" %s%s ", register, recording))
end

local function filename_component(args)
    if MiniStatusline.is_truncated(args.trunc_width) then
        return ""
    end
    if vim.bo.buftype == "terminal" then
        return "%t"
    else
        return "%f %m%r"
    end
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
    { name = "ERROR", sign = "E", hl = "DiagnosticSignError" },
    { name = "WARN", sign = "W", hl = "DiagnosticSignWarn" },
    { name = "INFO", sign = "I", hl = "DiagnosticSignInfo" },
    { name = "HINT", sign = "H", hl = "DiagnosticSignHint" },
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
    ["dapui_scopes"] = "DAP Scopes",
    ["dapui_breakpoints"] = "DAP Breakpoints",
    ["dapui_stacks"] = "DAP Stacks",
    ["dapui_watches"] = "DAP Watches",
    ["dap-repl"] = "DAP Repl",
    ["dapui_console"] = "DAP Console",
}

local function dap_component()
    return string.format("%s", dap_names[vim.bo.filetype])
end

local filetypes = {
    ["dapui_scopes"] = dap_component,
    ["dapui_breakpoints"] = dap_component,
    ["dapui_stacks"] = dap_component,
    ["dapui_watches"] = dap_component,
    ["dap-repl"] = dap_component,
    ["dapui_console"] = dap_component,
    ["oil"] = function()
        local ok, oil = pcall(require, "oil")
        if ok then
            return vim.fn.fnamemodify(oil.get_current_dir(), ":~")
        else
            return ""
        end
    end,
    ["man"] = function()
        local name = vim.fn.bufname():gsub("man://", "")
        return MiniStatusline.combine_groups({
            "MAN ",
            name,
            "%=",
            "%P ",
            "%l:%c",
        })
    end,
    ["qf"] = function()
        return MiniStatusline.combine_groups({
            "Quickfix List",
            "%=",
            "%l:%c",
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

return {
    filetype_specific = choose,
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
