local dap = require("dap")
local dapui = require("dapui")
require("dapui").setup()
require("dap-go").setup()
require("mason-nvim-dap").setup()
require("dap-python").setup("venv/bin/debugpy")

require("mason-nvim-dap").setup({
	ensure_installed = { "js", "delve" }
})

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
