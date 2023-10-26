return {
	"nvim-treesitter/nvim-treesitter",
	event = {"BufNewFile", "BufReadPost"},
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"JoosepAlviste/nvim-ts-context-commentstring",
		"nvim-treesitter/playground",
	},
	config = function()
		require("yoolayn.config.treesitter")
	end
}
