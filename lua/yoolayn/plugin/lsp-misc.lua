return {
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		lazy = true,
		opts = {
			text = {
				spinner = "moon",
			},
			window = {
				blend = 0,
			},
		}
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {
			max_height = 6,
			doc_lines = 6,
			hint_prefix = ":",
			hint_enable = false,
			toggle_key = "<c-t>",
		},
		config = function(_, opts) require "lsp_signature".setup(opts) end
	},
	{
		"dgagn/diagflow.nvim",
		opts = {
			max_width = 80,
			scope = "line",
			padding_top = 6,
			padding_right = 10,
			show_sign = false,
			format = function(diagnostic)
				local icons = require("util.icons").icons
				local severity = {
					icons.Error,
					icons.Warning,
					icons.Information,
					icons.Hint,
				}
				return severity[diagnostic.severity] .. " " .. diagnostic.message
			end
		}
	}
}
