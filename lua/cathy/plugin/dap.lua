---@diagnostic disable: undefined-field
require("mini.deps").add("mfussenegger/nvim-dap")
require("mini.deps").add("rcarriga/nvim-dap-ui")

local dap_ft = {
    "go",
}

local function isSetup(ft)
    if vim.b["dap_on"] == nil then
        vim.b["dap_on"] = vim.iter(dap_ft):any(function(v)
            return ft == v
        end)
    end
    return vim.b["dap_on"]
end

local enter = vim.api.nvim_replace_termcodes("norm! <cr>", true, true, true)

local function map(lhs, rhs, description, skip)
    local prefix = "<leader>z"
    if skip ~= nil then
        prefix = ""
    end
    vim.keymap.set("n", prefix .. lhs, function()
        if isSetup(vim.o.filetype) then
            rhs()
        else
            vim.cmd(enter)
        end
    end, { desc = description })
end

require("mini.deps").later(function()
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
    map("C", function() dap.run_to_cursor() end, "run to cursor")

    vim.fn.sign_define("DapBreakpoint", {text="", texthl="Error", linehl="", numhl=""})

    local ok, go = pcall(require, "gopher.dap")
    if ok then
        go.setup()
    end
end)
