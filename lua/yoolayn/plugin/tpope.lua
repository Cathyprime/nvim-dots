return {
	"tpope/vim-dispatch",
	{
		"tpope/vim-eunuch",
		cmd = {
			"Remove",
			"Delete",
			"Move",
			"Rename",
			"Copy",
			"Duplicate",
			"Chmod",
			"Mkdir",
			"Cfind",
			"Clocate",
			"Lfind",
			"Llocate",
			"Wall",
			"SudoWrite",
			"SudoEdit"
		}
	},
	{
		"tpope/vim-fugitive",
		cmd ={ "G", "Gclog" },
		keys = {
			{
				"<leader>gg",
				"<cmd>G<cr>"
			},
			{
				"<leader>gP",
				"<cmd>G push<cr>"
			},
		}
	},
}
