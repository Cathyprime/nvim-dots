return {
	{
		"j-hui/fidget.nvim",
		lazy = true,
		opts = {
			progress = {
				display = {
					progress_icon = {
						pattern = "moon",
						period = 1,
					},
				},
			},
			notification = {
				window = {
					winblend = 0,
				},
			}
		}
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {
			max_height = 6,
			doc_lines = 6,
			floating_window = true,
			hint_prefix = "",
			hint_enable = true,
			hint_inline = function()
				return false
			end,
			toggle_key = "<c-t>",
		},
		config = function(_, opts) require "lsp_signature".setup(opts) end
	},
	{
		"dgagn/diagflow.nvim",
		lazy = true,
		opts = {
			max_width = 50,
			scope = "line",
			padding_top = 2,
			padding_right = 6,
			show_sign = false,
			toggle_event = { "InsertEnter", "InsertLeave" },
			severity_colors = {
				error = "DiagnosticError"
			},
			format = function(diagnostic)
				local icons = require("util.icons").icons
				local severity = {
					icons.Error,
					icons.Warning,
					icons.Info,
					icons.Hint,
				}
				return severity[diagnostic.severity or 3] .. " " .. (diagnostic.message or "haii :3")
			end,
			enable = function()
				return vim.bo.filetype ~= "lazy"
			end
		}
	}
}
