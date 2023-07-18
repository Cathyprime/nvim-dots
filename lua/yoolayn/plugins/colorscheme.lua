return {
	{
		"rose-pine/neovim",
		priority = 1000,
		name = "rose-pine",
	},
	{
		"navarasu/onedark.nvim",
		lazy = true,
		opts = { style = "deep" },
	},
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
	},
	{
		"sainnhe/everforest",
		lazy = true,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
	},
	{
		"cpea2506/one_monokai.nvim",
		lazy = true,
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = true,
	},
	{
		"AlexvZyl/nordic.nvim",
		lazy = true,
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
	},
	{
		"xero/miasma.nvim",
		lazy = true,
	},
	{
		"lunarvim/Onedarker.nvim",
		lazy = true,
	},
	{
		"marko-cerovac/material.nvim",
		lazy = true,
		opts = {
			plugins = { -- Uncomment the plugins that you use to highlight them
				-- Available plugins:
				-- "dap",
				-- "dashboard",
				-- "gitsigns",
				-- "hop",
				"indent-blankline",
				-- "lspsaga",
				"mini",
				-- "neogit",
				-- "neorg",
				"nvim-cmp",
				-- "nvim-navic",
				-- "nvim-tree",
				"nvim-web-devicons",
				-- "sneak",
				"telescope",
				"trouble",
				-- "which-key",
			},
			disable = {
				colored_cursor = true,
			},
		},
	},
}
