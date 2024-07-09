local on = true
local root_names = {
    "%.csproj$",
    "docker%-compose%.yml",
    "build%.sbt",
    "Cargo%.toml",
    "go%.mod",
    "gradlew",
    "/lua",
    "Makefile",
    "package%.json",
    "%.git",
}

local disabled_filetype = {
    "help",
    "Neogit.*",
}

local function isBanned(ft)
    if ft == "" then return true end
    return vim.iter(disabled_filetype):any(function(v)
        return ft:match(v)
    end)
end

local function set_root()
    if isBanned(vim.o.filetype) then return end
    if not on then return end
    local path = vim.api.nvim_buf_get_name(0)
    if path == "" then return end

    local root = vim.fs.root(0, function(name)
        return vim.iter(root_names):any(function(value)
            return name:match(value)
        end)
    end)

    local old = vim.fn.getcwd()
    if old ~= root and root ~= "." and root ~= "/" and root ~= nil then
        vim.notify(string.format("cwd: %s", root), vim.log.levels.INFO)
        vim.fn.chdir(root)
    end
end

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("rooter", {}),
    callback = set_root,
})

local switch = {
    enable = function(notif)
        if not on then
            notif("Rooter: on")
            on = true
        end
    end,
    disable = function(notif)
        if on then
            notif("Rooter: off")
            on = false
        end
    end,
    toggle = function(notif)
        on = not on
        if on then
            notif("Rooter: on")
        else
            notif("Rooter: off")
        end
    end,
    status = function(notif)
        if on then
            notif("Rooter: on")
        else
            notif("Rooter: off")
        end
    end,
    cwd = function(notif)
        notif(string.format("cwd: %s", vim.fn.getcwd()), vim.log.levels.INFO)
    end
}

vim.api.nvim_create_user_command(
    "Rooter",
    function(opts)
        local notif = function(msg, level)
            level = level or vim.log.levels.INFO
            vim.notify(msg, level)
        end
        if opts.smods.silent then
            notif = function() end
        end
        if opts.args == "" then
            set_root()
        else
            local f = switch[opts.args]
            if f == nil then
                notif("Rooter: unknown command", vim.log.levels.ERROR)
                return
            end
            f(notif)
        end
    end,
    {
        nargs = "*",
        complete = function(arg_lead)
            return vim.iter({ "enable", "disable", "toggle", "status", "cwd" }):filter(function(el)
                return el:lower():match("^" .. arg_lead)
            end):totable()
        end
    }
)
