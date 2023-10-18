return {
	"scalameta/nvim-metals",
	event = {"BufEnter", "BufReadPre"},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "scala", "sbt", "java" },
			callback = function()
				require("metals").initialize_or_attach({})
			end,
			group = nvim_metals_group,
		})
	end
}
