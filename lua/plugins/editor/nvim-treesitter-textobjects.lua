return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	init = function()
		require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
		load_textobjects = true
	end,
}
