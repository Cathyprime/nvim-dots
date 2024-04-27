vim.cmd.packadd("nvim-dap-ui")
vim.cmd.packadd("nvim-dap-go")

local function map(lhs, rhs, description, skip)
    local prefix = "<leader>z"
    if skip ~= nil then
        prefix = ""
    end
    vim.keymap.set("n", prefix .. lhs, rhs, { desc = description, buffer = true })
end

local dap = require("dap")
local dapui = require("dapui")

dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("cathy_dap", { clear = true }),
    pattern = {
        "*scala",
        "*rs",
        "*go",
    },
    callback = function()
        map("<cr>", function() dap.toggle_breakpoint() vim.cmd("norm j") end, "toggle a breakpoint", true)
        map("<cr>", function() dap.toggle_breakpoint() vim.cmd("norm j") end, "toggle a breakpoint")
        map("B", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, "breakpoint condition")
        map("i", function() dap.step_into() end, "step into")
        map("l", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, "log breakpoint")
        map("o", function() dap.step_over() end, "step over")
        map("O", function() dap.step_out() end, "step out")
        map("u", function() dapui.toggle() end, "toggle ui")
        map("s", function() dap.continue() end, "continue")
        map("z", function() dap.continue() end, "continue")
        map("C", function() dap.close() end, "close")
        map("r", function() dap.reverse_continue() end, "reverse")
        map("c", function() dap.run_to_cursor() end, "run to cursor")
    end
})

vim.fn.sign_define("DapBreakpoint", {text="", texthl="Error", linehl="", numhl=""})
