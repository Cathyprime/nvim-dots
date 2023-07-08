return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	event = { "BufReadPost", "BufNewFile" },
	init = function()
		require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
		load_textobjects = true
	end,
}
