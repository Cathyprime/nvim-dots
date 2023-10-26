return {
	"L3MON4D3/LuaSnip",
	event = {"BufEnter", "BufReadPre"},
	config = function()
		require("yoolayn.config.luasnip")
	end
}
