local M = {}

function M.new(opts)
    if opts.map then
        local i = setmetatable({}, { __index = M })
        i.map = opts.map
        i.command = opts.command
        i.nargs = opts.nargs
        return i
    end
end

function M.enable(opts)
    if opts and opts.command and opts.map and opts.pattern then
        return M
    else
        return nil
    end
end

function M.create_completion(self)
    return vim.iter(self.map):fold({}, function(acc, item)
        table.insert(acc, item)
        return acc
    end)
end

function M.func(self, opts)
    if type(self.map) == "string" or type(self.map) == "function" then
        if type(self.map) == "string" then
            vim.cmd(self.map)
        elseif type(self.map) == "function" then
            self.map()
        end
        return
    end
    local farg = opts.fargs[1]
    if self.map[farg] and type(self.map[farg]) == "string" then
        vim.cmd(self.map[farg])
        return
    elseif self.map[farg] and type(self.map[farg]) == "function" then
        self.map[farg]()
        return
    end
    vim.notify(string.format("ERROR: unknown argument %s", farg), vim.log.levels.ERROR)
end

function M.setup(self)
    vim.api.nvim_create_autocmd("BufReadPost", {
        once = false,
        callback = function()
            self:create_cmd()
        end
    })
end

function M.create_cmd(self)
    vim.api.nvim_create_user_command(
        self.command,
        function(opts)
            self:func(opts)
        end,
        (function()
            local ret = { nargs = self.nargs }
            if self.nargs == 1 then
                ret["complete"] = function()
                    return self:create_completion()
                end
            end
            return ret
        end)()
    )
end

return M
