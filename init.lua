vim.g.mapleader = vim.keycode "<space>"
vim.g.localleader = [[\]]
vim.g.dispatch_no_maps = true
vim.o.background = "dark"

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

SWITCHES = {
    files = "oil",
    scala = true,
    go    = true,
    dap   = true,
    rust  = true,
}

if SWITCHES.files ~= nil then
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
end

pcall(require, "cathy.lazy")
pcall(require, "cathy.globals")
require("cathy.config.options")
