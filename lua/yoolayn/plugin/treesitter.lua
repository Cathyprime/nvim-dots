return {
	"nvim-treesitter/nvim-treesitter",
	event = {"BufNewFile", "BufReadPost", "InsertEnter" },
	build = "TSUpdateSync",
	cmd = { "TSUpdate", "TSUpdateSync", "TSToggle" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		require("yoolayn.config.treesitter")
	end
}
