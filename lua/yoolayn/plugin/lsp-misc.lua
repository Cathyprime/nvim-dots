return {
	{
		"dgagn/diagflow.nvim",
		event = {"BufEnter", "BufReadPre"},
		opts = {
			scope = "line"
		}
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = {"BufEnter", "BufReadPre"},
		opts = {
			text = {
				spinner = "moon",
			},
			window = {
				blend = 0,
			},
		}
	},
}
