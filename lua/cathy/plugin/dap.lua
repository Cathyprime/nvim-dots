return {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
    },
    keys = { { "<leader>z" } },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        require("mason-nvim-dap").setup({
            ensure_installed = {
                "debugpy",
                "delve",
                "netcoredbg"
            },
            automatic_installation = true,
            handlers = {
                function(config)
                    require("mason-nvim-dap").default_setup(config)
                end
            },
        })

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

        local hint = [[
 _n_: step over   _J_: to cursor  _<cr>_: Breakpoint
 _i_: step into   _X_: Quit        _B_: Condition breakpoint ^
 _o_: step out    _K_: Hover       _L_: Log breakpoint
 _b_: step back   _u_: Toggle UI
 ^ ^            ^                 ^  ^
 ^ ^ _C_: Continue/Start          ^  ^   Change window
 ^ ^ _R_: Reverse continue        ^  ^       _<c-k>_^
 ^ ^            ^                 ^  _<c-h>_ ^     ^ _<c-l>_
 ^ ^     _<esc>_: exit            ^  ^       _<c-j>_^
 ^ ^            ^
]]

        require("hydra")({
            hint = hint,
            config = {
                color = "pink",
                invoke_on_body = true,
                hint = {
                    position = "middle-right",
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
                {"b", function() dap.step_back() end, { silent = false }},
                {"R", function() dap.reverse_continue() end, { silent = false }},
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
                {"<c-h>", "<c-w><c-h>", { silent = true }},
                {"<c-j>", "<c-w><c-j>", { silent = true }},
                {"<c-k>", "<c-w><c-k>", { silent = true }},
                {"<c-l>", "<c-w><c-l>", { silent = true }},
                {"<esc>", nil, { exit = true,  silent = false  }},
            }
        })

        vim.fn.sign_define("DapBreakpoint", { text="", texthl="Error", linehl="", numhl="" })
    end
}
