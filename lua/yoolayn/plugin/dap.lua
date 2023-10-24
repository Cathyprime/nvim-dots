return {
	"mfussenegger/nvim-dap",
	event = "VimEnter",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		require("nvim-dap-virtual-text").setup()
		require("dapui").setup()
		require("dap-go").setup()

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "::1",
			port = 8123,
			executable = {
				command = "js-debug-adapter",
			}
		}

		for _, language in ipairs { "typescript", "javascript" } do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
					runtimeExecutable = "node",
				},
			}
		end

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		vim.fn.sign_define("DapStopped", { text = "ඞ", texthl = "Error" })
	end,
}
