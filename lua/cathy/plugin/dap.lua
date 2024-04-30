vim.cmd.packadd("nvim-dap-ui")
vim.cmd.packadd("nvim-dap-go")

local dap = require("dap")
local dapui = require("dapui")

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    vim.cmd("silent Rooter disable")
    dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    vim.cmd("silent Rooter enable")
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    vim.cmd("silent Rooter enable")
    dapui.close()
end

dap.adapters.coreclr = {
    type = "executable",
    command = require("mason-core.path").bin_prefix() .."/netcoredbg",
    args = { "--interpreter=vscode" }
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
    },
}

local hint = [[
 _n_: step over   _C_: Continue/Start   _<cr>_: Breakpoint
 _i_: step into   _X_: Quit               _B_:  Condition breakpoint
 _o_: step out    _K_: Hover              _L_:  Log breakpoint
 _J_: to cursor   _u_: Close UI
 ^
 ^ ^            _<esc>_: exit
]]

require("hydra")({
    hint = hint,
    config = {
        color = "pink",
        invoke_on_body = true,
        hint = {
            position = "bottom",
            float_opts = {
                border = "rounded",
            }
        },
    },
    name = "dap",
    mode = { "n", "x" },
    body = "<leader>z",
    heads = {
        {"<cr>", function() dap.toggle_breakpoint() end, { silent = true } },
        {"B", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { silent = true }},
        {"L", function()
            vim.ui.input({ prompt = "Log point message: " }, function(input)
                dap.set_breakpoint(nil, nil, input)
            end)
        end, { silent = false }},
        {"i", function() dap.step_into() end, { silent = false }},
        {"n", function() dap.step_over() end, { silent = false }},
        {"o", function() dap.step_out() end, { silent = false }},
        {"u", function()
            local ok, _ = pcall(dapui.toggle)
            if not ok then
                vim.notify("no active session", vim.log.levels.INFO)
            end
        end, { silent = false }},
        {"C", function() dap.continue() end, { silent = false }},
        {"K", function() require("dap.ui.widgets").hover() end, { silent = false }},
        {"J", function() dap.run_to_cursor() end, { silent = false }},
        {"X", function() dap.disconnect({ terminateDebuggee = false }) end, { silent = false }},
        {"<esc>", nil, { exit = true,  silent = false  }},
    }
})

vim.fn.sign_define("DapBreakpoint", { text="", texthl="Error", linehl="", numhl="" })
