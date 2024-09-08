local M = {}

--- key: [register name], value: [new content]
--- ---
--- will set value of (a-z) register to the new value on VimEnter
--- will reset the set registers back to previous value, from before settings
---
--- [Attention]:
--- if value was overwritten with another then it will still be set to the old one
---@param opts table<string, string>
---
--- [Example]:
--- require("project").registers({ a = ":echo 'Hello, World!'\n" })
function M.registers(opts)
    require("project.registers").new(opts):start()
end

---@alias nargs
---| 1 will set subcommands
---| 0 won't set subcommands

---@class ProjectCommand
---@field nargs nargs number of arguments
---@field command string The name of the invoked command
---@field map table<string, string|function>

--- ProjectCommand: {
---     nargs: 1 | 0,
---     command: string
---     map: nargs == 0
---         ? string | function
---         : table<string, string | function>
--- }
--- ---
--- creates a command for the current project
--- it's a global command, that is set as soon as sourced
---@param opts ProjectCommand
---
--- [Example]:
--- require("project").command({
---     nargs = 0,
---     command = "Hello",
---     map = "echo 'Hello, World!'"
---})
function M.command(opts)
    require("project.commands").new(opts):create_cmd()
end

return M
