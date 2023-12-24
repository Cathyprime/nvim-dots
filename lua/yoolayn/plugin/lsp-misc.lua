return {
	{
		"j-hui/fidget.nvim",
		lazy = true,
		opts = {
			progress = {
				display = {
					progress_icon = {
						pattern = "moon",
						period = 1,
					},
				},
			},
			notification = {
				window = {
					winblend = 0,
				},
			}
		}
	},
}
