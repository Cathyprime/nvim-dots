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
		require("yoolayn.config.dap")
	end,
}
