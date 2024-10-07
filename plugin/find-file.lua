local ff = require("cathy.find-file")
local Path = require("plenary.path")

local on_complete = function(path)
    vim.cmd("edit " .. path)
    if Path:new(path):is_dir() then
        vim.cmd.cd(path)
    end
end

vim.api.nvim_create_user_command("FindFile", function()
    ff.set_prefix("Find File ::")
    ff.find_file(on_complete, ff.default_mappings())
end, {})
