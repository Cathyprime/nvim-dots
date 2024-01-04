local M = {}

function M.registers(opts)
    require("project.registers").new(opts):start()
end

function M.commands(opts)
    require("project.commands").new(opts):create_cmd()
end

return M
