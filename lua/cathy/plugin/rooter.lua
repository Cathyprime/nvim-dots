local on = true
local root_cache = {}
local root_names = {
    "build",
    "build.sbt",
    "Cargo.toml",
    ".git",
    "go.mod",
    "gradlew",
    "lua",
    "Makefile",
    "obj",
    "package.json",
}

local function set_root()
    if not on then return end
    local path = vim.api.nvim_buf_get_name(0)
    if path == "" then return end

    path = vim.fs.dirname(path)
    local root = root_cache[path]
    if root == nil then
        local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
        if root_file == nil then return end
        root = vim.fs.dirname(root_file)
        root_cache[path] = root
    end

    local old = vim.fn.getcwd()
    if old ~= root and root ~= "." and root ~= "/" then
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
