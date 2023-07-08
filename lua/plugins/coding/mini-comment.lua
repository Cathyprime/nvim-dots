return {
	"echasnovski/mini.comment",
	keys = {
		{ "gc" },
		{ "gcc" },
	},
	opts = {
		options = {
			custom_commentstring = function()
				return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
			end,
		},
	},
}
