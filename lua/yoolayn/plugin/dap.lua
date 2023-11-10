return {
	"mfussenegger/nvim-dap",
	event = "VimEnter",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"leoluz/nvim-dap-go",
	},
	config = function()
		require("yoolayn.config.dap")
	end,
}
