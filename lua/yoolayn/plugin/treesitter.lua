return {
	"nvim-treesitter/nvim-treesitter",
	event = {"BufNewFile", "BufReadPost", "InsertEnter" },
	cmd = "TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		require("yoolayn.config.treesitter")
	end
}
