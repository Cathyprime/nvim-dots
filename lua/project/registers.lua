local M = {}

M.registers = {}

function M.new(opts)
    local i = setmetatable({}, { __index = M })
    i.registers.new = opts
    i.registers.old = {}
    return i
end

function M.enable(opts)
    if opts then
        return M
    else
        return nil
    end
end

function M.start(self)
    vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = function()
            self:on_enter()
            self:on_leave()
        end
    })
end

function M.on_enter(self)
    local regs = vim.iter(self.registers.new)
        :fold("", function(acc, reg, cmd)
            self.registers.old[reg] = vim.fn.getreg(reg)
            vim.fn.setreg(reg, vim.api.nvim_replace_termcodes(cmd, true, true, true))
            return string.format("%s%s", acc, reg)
        end)
    vim.keymap.set("n", "<leader>h", string.format("<cmd>reg %s<cr>", regs), { silent = true })
end

function M.on_leave(self)
    vim.api.nvim_create_autocmd("VimLeavePre", {
        once = true,
        callback = function()
            vim.iter(self.registers.old):each(function(reg, content)
                vim.fn.setreg(reg, content)
            end)
        end
    })
end

return M
