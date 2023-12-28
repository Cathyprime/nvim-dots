return {
	"neanias/everforest-nvim",
	config = function()
		require("everforest").setup({
			transparent_background_level = 0
		})
	end
}
