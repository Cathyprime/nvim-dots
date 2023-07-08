return {
	"SmiteshP/nvim-navic",
	lazy = true,
	init = function()
		vim.g.navic_silence = true
		require("yoolayn.util.funcs").on_attach(function(client, buffer)
			if client.server_capabilities.documentSymbolProvider then
				require("nvim-navic").attach(client, buffer)
			end
		end)
	end,
	opts = function()
		return {
			separator = " ",
			highlight = true,
			depth_limit = 5,
			icons = require("yoolayn.data.icons").kinds,
		}
	end,
}
