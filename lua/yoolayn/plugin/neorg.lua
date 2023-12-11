return {
	"nvim-neorg/neorg",
	build = ":Neorg sync-parsers",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
			pattern = "*.norg",
			command = "setlocal conceallevel=3"
		})
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {
					config = {
						icons = {
							heading = false,
						}
					}
				},
				["core.export"] = { config = { export_dir = "~/Documents/neorg/exported" } },
				["core.ui.calendar"] = {},
				["core.dirman"] = {
					config = {
						workspaces = { notes = "~/Documents/neorg/notes" },
						default_workspace = "notes"
					}
				}
			}
		})
	end
}
