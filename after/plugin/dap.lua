local ok, dap = pcall(require, "dap")
if not ok then return end

require("nvim-dap-virtual-text").setup()
require("dapui").setup()
require("dap-go").setup()

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

dap.configurations.scala = {
	{
		type = "scala",
		request = "launch",
		name = "Run with arg and env file",
		metals = {
		},
	}
}

vim.fn.sign_define("DapStopped", { text = "ඞ", texthl = "Error" })
