return {
	"echasnovski/mini.surround",
	keys = function(_, keys)
		-- Populate the keys based on the user's options
		local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
		local opts = require("lazy.core.plugin").values(plugin, "opts", false)
		local mappings = {
			{ opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
			{ opts.mappings.delete, desc = "Delete surrounding" },
			{ opts.mappings.replace, desc = "Replace surrounding" },
		}
		mappings = vim.tbl_filter(function(m)
			return m[1] and #m[1] > 0
		end, mappings)
		return vim.list_extend(mappings, keys)
	end,
	opts = {
		mappings = {
			add = "gza",
			delete = "gzd",
			replace = "gzr",
		},
	},
}
