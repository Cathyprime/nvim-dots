local on = true
local root_names = {
    "build.sbt",
    "Cargo.toml",
    ".git",
    "go.mod",
    "gradlew",
    "lua",
    "Makefile",
    "package.json",
    "%.csproj$"
}

local disabled_filetype = {
    "help",
}

local function isBanned(ft)
    if ft == "" then return true end
    for _, v in ipairs(disabled_filetype) do
        if v == ft then
            return true
        end
    end
    return false
end

local function set_root()
    if isBanned(vim.o.filetype) then return end
    if not on then return end
    local path = vim.api.nvim_buf_get_name(0)
    if path == "" then return end

    local root = vim.fs.root(0, function(name)
        local found = false
        for _, value in ipairs(root_names) do
            found = value == name or name:match('%.csproj$')
            if found then
                break
            end
        end
        return found
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

vim.api.nvim_create_user_command(
    "Rooter",
    function()
        on = not on
        if on then
            vim.notify("Rooter is on", vim.log.levels.INFO)
        else
            vim.notify("Rooter is off", vim.log.levels.INFO)
        end
    end,
    {}
)
