local function create_cmd(command, arg)
    local completion = {}

    local n = 0
    for k, _ in pairs(arg) do
        n = n + 1
        completion[n] = k
    end

    vim.api.nvim_buf_create_user_command(
        0,
        command,
        function(opts)
            local farg = opts.fargs[1]
            if arg[farg] and type(arg[farg]) == "string" then
                vim.cmd(arg[farg])
                return
            elseif arg[farg] and type(arg[farg]) == "function" then
                arg[farg]()
                return
            end
            print(string.format("ERROR: unknown argument %s", farg))
        end,
        {
            nargs = 1,
            complete = function(_) return completion end,
        }
    )
end
