local cached_mappings = {}

local Path = require("plenary.path")
local home = os.getenv("HOME")
local prefix = ""
local function set_prefix(str)
    prefix = str .. " "
end

local function create_dummy_command()
    local cmd
    local pos = prefix:find(" ")
    if pos then
        cmd = prefix:sub(1, pos - 1)
    else
        cmd = prefix
    end
    vim.api.nvim_create_user_command(cmd, function() end, {
        complete = "file",
        nargs = "*"
    })
    vim.api.nvim_create_autocmd("CmdlineLeave", {
        once = true,
        callback = function()
            vim.api.nvim_del_user_command(cmd)
        end,
    })
end

local function normalize_path(path)
    local p = Path:new(path):absolute()
    return tostring(p)
end

local function cmdline(arg)
    if arg == nil then
        return vim.fn.getcmdline(), vim.fn.getcmdpos()
    end

    if type(arg) == "number" then
        vim.fn.setcmdpos(arg)
    end

    if type(arg) == "string" then
        vim.fn.setcmdline(arg)
    end

    if type(arg) == "table" then
        if arg.line and arg.pos then
            vim.fn.setcmdline(arg.line, arg.pos)
        end
    end
end

local function last(str)
    return string.sub(str, -1)
end

local function set_map(lhs, rhs)
    vim.keymap.set("c", lhs, rhs)
    cached_mappings[lhs] = rhs
end

local function line_path()
    local line = cmdline()
    local x = string.sub(line, #prefix + 1)
    print(x)
    return x
end

local function backspace()
    local line = cmdline()
    if last(line) == "/" then
        local pos = line:sub(1, #line - 1):find(".*/")
        local linerus = prefix .. tostring(Path:new(line_path()):parent())
        print(linerus)
        if last(linerus) ~= "/" then
            linerus = linerus .. "/"
        end
        cmdline({ line = linerus, pos = #linerus + 1 })
        return
    end
    vim.api.nvim_feedkeys(vim.keycode "<bs>", "n", false)
end

local function c_w()
    local line = cmdline()
    if last(line) == "/" then
        backspace()
        return
    end
    local last_slash = string.find(line, "/[^/]*$")
    local line = string.sub(line, 1, last_slash)
    cmdline({ line = line, pos = #line + 1 })
end

local function start_updater(cb, start_path)
    start_path = start_path or home .. "/"
    local group = vim.api.nvim_create_augroup("find-file", { clear = false })
    vim.api.nvim_create_autocmd("CmdlineChanged", {
        once = true,
        callback = function()
            cmdline(string.format("%s%s", prefix, start_path))
            vim.api.nvim_create_autocmd("CmdlineChanged", {
                group = group,
                callback = function()
                    local _, pos = cmdline()
                    if pos <= #prefix then
                        cmdline(prefix)
                    end
                end,
            })
        end,
    })
    vim.api.nvim_create_autocmd("CmdlineLeave", {
        group = group,
        once = true,
        callback = function()
            vim.api.nvim_del_augroup_by_id(group)
            if vim.v.event.abort then
                return
            end
            vim.v.event.abort = true
            local line = line_path()
            cmdline("")
            cb(line)
        end,
    })
end

local function get_cwd()
    local p = vim.fn.expand("%:p:h") .. "/"
    return normalize_path(p)
end

local function set_keymaps()
    set_map("<bs>", backspace)
    set_map("<c-w>", c_w)
    vim.api.nvim_create_autocmd("CmdlineLeave", {
        once = true,
        callback = function()
            for lhs in pairs(cached_mappings) do
                vim.keymap.del("c", lhs)
            end
        end,
    })
end

local function find_file(cb)
    set_keymaps()
    local path = get_cwd()
    start_updater(vim.schedule_wrap(cb), path)
    vim.api.nvim_feedkeys(":e", "n", false)
end

vim.api.nvim_create_user_command("FindFile", function()
    set_prefix("Find File ::")
    create_dummy_command()
    find_file(function(path)
        vim.cmd("edit " .. path)
    end)
end, {})
