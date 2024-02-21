local auto_colors = require("lualine.themes.auto")
local separators = {
    component = {
        left = "│",
        right = "│"
    },
    section = {
        left = "",
        right = ""
    }
}

-- default
-- local separators = {
--     component = {
--         left = "",
--         right = ""
--     },
--     section = {
--         left = "",
--         right = ""
--     }
-- }

auto_colors.inactive.a.bg = auto_colors.normal.a.bg
auto_colors.inactive.b.bg = auto_colors.normal.b.bg
auto_colors.inactive.c.bg = auto_colors.normal.c.bg

local mode = {
    colors = {
        -- TODO: set colors to better match the lualine colors so it isn't so jarring
        ["normal"] = { bg = "#571cbd", fg = "#c8c093" },
        ["visual"] = { bg = "#76946a", fg = "#181818" },
        ["vislin"] = { bg = "#ad410e", fg = "#c8c093" },
        ["visblk"] = { bg = "#181818", fg = "#80a0ff" },
        ["oppend"] = { bg = "#e6c384", fg = "#181818" },
        ["select"] = { bg = "#80a0ff", fg = "#003366" },
        ["sellin"] = { bg = "#80a0ff", fg = "#003366" },
        ["selblk"] = { bg = "#80a0ff", fg = "#003366" },
        ["insert"] = { bg = "#7e9cd8", fg = "#181818" },
        ["replce"] = { bg = "#ce0406", fg = "#181818" },
        ["replin"] = { bg = "#ce0406", fg = "#181818" },
        ["cmmand"] = { bg = "#ffa066", fg = "#181818" },
        ["termnl"] = { bg = "#181818", fg = "#e6c384" },
        ["confrm"] = { bg = "#571cbd", fg = "#c8c093" },
        ["unknwn"] = { bg = "black", fg = "white" },
    },
    modes = {
        ["n"] = "normal",
        ["niI"] = "normal",
        ["niR"] = "normal",
        ["niV"] = "normal",
        ["nt"] = "normal",
        ["ntT"] = "normal",
        ["v"] = "visual",
        ["vs"] = "visual",
        ["V"] = "vislin",
        ["Vs"] = "vislin",
        [""] = "visblk",
        ["s"] = "visblk",
        ["no"] = "oppend",
        ["nov"] = "oppend",
        ["noV"] = "oppend",
        ["no"] = "oppend",
        ["s"] = "select",
        ["S"] = "sellin",
        [""] = "selblk",
        ["i"] = "insert",
        ["ic"] = "insert",
        ["ix"] = "insert",
        ["R"] = "replce",
        ["Rc"] = "replce",
        ["Rx"] = "replce",
        ["r"] = "replce",
        ["Rv"] = "replin",
        ["Rvc"] = "replin",
        ["Rvx"] = "replin",
        ["c"] = "cmmand",
        ["cv"] = "cmmand",
        ["ce"] = "cmmand",
        ["t"] = "termnl",
        ["r?"] = "confrm",
        ["default"] = "unknwn",
    },
    name = {
        ["normal"] = "[ Normal ]",
        ["visual"] = "[ Visual ]",
        ["vislin"] = "[ VisLin ]",
        ["visblk"] = "[ VisBlk ]",
        ["oppend"] = "[ OpPend ]",
        ["select"] = "--Select--",
        ["sellin"] = "--SelLin--",
        ["selblk"] = "--SelBlk--",
        ["insert"] = "--Insert--",
        ["replce"] = "--Replce--",
        ["replin"] = "--RepLin--",
        ["cmmand"] = "--Cmmand--",
        ["termnl"] = "--Termnl--",
        ["confrm"] = "--Confrm--",
        ["unknwn"] = "--[????]--",
    },
}

local function mode_component()
    local mode_name = mode.modes[vim.fn.mode()]
    local mode_str = mode.name[mode_name]
    return mode_str
end

local function window_component()
    return string.format("[%s:%s]", vim.api.nvim_win_get_number(0), vim.api.nvim_get_current_buf())
end

local function recording_component()
    local recording = vim.fn.reg_recording()
    if recording ~= "" then
        recording = string.format("   -> %s", recording)
    end
    local register = vim.v.register
    if register == "%" then
        register = "%%"
    end
    return string.format("%s%s", register, recording)
end

local function get_cb(arg)
    if type(arg) == "function" then
        return arg
    else
        return function(_)
            return ""
        end
    end
end

local function hide_on_vert(str, cb)
    local func = get_cb(cb)
    local cols = vim.opt.columns:get()
    local win_cols = vim.api.nvim_win_get_width(0)
    if win_cols < cols * 0.7 then
        str = func(str)
    end
    return str
end

local function location_fmt(str)
    return string.format("(%s)", str):gsub("%s+", "")
end

local config = {
    options = {
        icons_enabled = false,
        theme = auto_colors,
        component_separators = separators.component,
        section_separators = separators.section,
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 100,
            tabline = 1000,
            winbar = 1000,
        },
    },
    sections = {
        lualine_a = {
            {
                mode_component,
                color = function()
                    local mode_name = mode.modes[vim.fn.mode()]
                    return mode.colors[mode_name]
                end,
                separator = { right = separators.section.left },
                fmt = function(str)
                    if vim.o.filetype == "neo-tree" or vim.o.filetype == "undotree" then
                        return nil
                    end
                    return str
                end
            },
            {
                recording_component,
                color = function()
                    if vim.fn.reg_recording() ~= "" then
                        return { bg = "red", fg = "white" }
                    end
                end,
                separator = { right = separators.section.left },
                fmt = function(str)
                    if vim.o.filetype == "neotree" then
                        return nil
                    end
                    return str
                end
            },
        },
        lualine_b = { "branch", "diff" },
        lualine_c = {
            {
                "filename",
                path = 1,
                fmt = function(str)
                    if vim.o.filetype == "neo-tree" or vim.o.filetype == "undotree" then
                        return nil
                    end
                    return hide_on_vert(str, function(_)
                        local split = vim.split(str, "/", {})
                        return split[#split]
                    end)
                end,
            },
        },
        lualine_x = {
            {
                "%S",
                fmt = function(str)
                    if vim.o.filetype == "neo-tree" or vim.o.filetype == "undotree" then
                        return nil
                    end
                    return str
                end
            },
            "searchcount",
            "selectioncount",
            "diagnostics",
        },
        lualine_y = {
            {
                "filetype",
                fmt = function(str)
                    if str == "TelescopePrompt" then
                        return "Telescope"
                    end
                    str = hide_on_vert(str)
                    return str
                end,
            },
            { "fileformat", fmt = hide_on_vert },
            {
                "progress",
                fmt = function(str)
                    if vim.o.filetype == "neo-tree" or vim.o.filetype == "undotree" then
                        return nil
                    end
                    return str
                end
            },
        },
        lualine_z = {
            { "location", fmt = location_fmt },
            window_component,
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            {
                "filename",
                path = 1,
                fmt = function(str)
                    if vim.o.filetype == "neo-tree" or vim.o.filetype == "undotree" then
                        return nil
                    end
                    return str
                end
            },
        },
        lualine_x = {
            {
                "progress",
                fmt = function(str)
                    if vim.o.filetype == "neo-tree" or vim.o.filetype == "undotree" then
                        return nil
                    end
                    return str
                end
            },
            {
                "location",
                fmt = location_fmt,
            },
        },
        lualine_y = { window_component },
        lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
}

return config
