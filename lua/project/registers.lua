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
    local regs = ""
    for reg, cmd in pairs(self.registers.new) do
        regs = string.format("%s%s", regs, reg)
        self.registers.old[reg] = vim.fn.getreg(reg)
        vim.fn.setreg(reg, vim.api.nvim_replace_termcodes(cmd, true, true, true))
    end
    vim.keymap.set("n", "<leader>h", string.format("<cmd>reg %s<cr>", regs), { silent = true })
end

function M.on_leave(self)
    vim.api.nvim_create_autocmd("VimLeavePre", {
        once = true,
        callback = function()
            for reg, content in pairs(self.registers.old) do
                vim.fn.setreg(reg, content)
            end
        end
    })
end

return M
