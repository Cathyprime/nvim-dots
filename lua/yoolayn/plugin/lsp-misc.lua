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
		"dgagn/diagflow.nvim",
		lazy = true,
		init = function()
			vim.keymap.set("n", "<leader>td", require("diagflow").toggle)
		end,
		opts = {
			max_width = 80,
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
