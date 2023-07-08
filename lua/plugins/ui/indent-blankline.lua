return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		-- char = "▏",
		char = "│",
		filetype_exclude = {
			"help",
			"dashboard",
			"Trouble",
			"lazy",
			"mason",
			"notify",
			"toggleterm",
			"lazyterm",
		},
		show_trailing_blankline_indent = false,
		show_current_context = false,
	},
}
