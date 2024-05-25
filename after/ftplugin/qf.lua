vim.cmd.packadd "cfilter"
vim.opt_local.spell = false

local function cmd(command)
    return function()
        local count = vim.v.count
        if count ~= 0 then
            command = command .. " " .. count
        end
        print(count)
        return string.format("<cmd>silent! unsilent %s<cr>", command)
    end
end

vim.keymap.set("n", "<", cmd("colder"), { buffer = true, silent = true, expr = true })
vim.keymap.set("n", ">", cmd("cnewer"), { buffer = true, silent = true, expr = true })
