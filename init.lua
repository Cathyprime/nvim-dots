vim.g.mapleader = " "
vim.g.localleader = "\\"

if vim.fn.executable("luarocks") == 1 then
    local rocks_config = {
        rocks_path = vim.fn.stdpath("data") .. "/rocks",
        luarocks_binary = "luarocks",
    }

    vim.g.rocks_nvim = rocks_config

    local luarocks_path = {
        vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
        vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
    }
    package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

    local luarocks_cpath = {
        vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
        vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
    }
    package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

    vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*"))

    if not vim.loop.fs_stat(vim.g.rocks_nvim.rocks_path) then
        vim.system({
                "luarocks",
                "--lua-version=5.1",
                "--tree",
                vim.g.rocks_nvim.rocks_path,
                "--server='https://nvim-neorocks.github.io/rocks-binaries/'",
                "install",
                "rocks.nvim"
            },
            nil,
            vim.schedule_wrap(function()
                require("rocks.commands").create_commands()
                vim.cmd("Rocks sync")
            end)
        )
    end
end

SWITCHES = {
    files = "oil",
    scala = true,
    java  = true,
    dap   = true,
    go    = true,
}

pcall(require, "cathy.minideps")
pcall(require, "cathy.globals")
require("cathy.config.options")
