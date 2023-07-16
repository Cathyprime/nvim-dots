return {
	{
		"mbbill/undotree",
		keys = {
			{
				"<leader>u",
				"<cmd>UndotreeToggle<cr>",
				desc = "Undo tree",
			},
		},
	},
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{
				"<C-h>",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				desc = "Menu",
			},
			{
				"<leader>a",
				function()
					require("harpoon.mark").add_file()
				end,
				desc = "Add File",
			},
			{
				"<leader>hg",
				function()
					local result = vim.fn.input({ prompt = "Enter mark number: " })
					local number = tonumber(result)
					if number ~= nil then
						require("harpoon.ui").nav_file(number)
					else
						vim.api.nvim_echo({ { "Enter a number!", "Normal" } }, true, {})
					end
				end,
				desc = "go to mark {arg}",
			},
			{
				"<leader>hf",
				"<cmd>Telescope harpoon marks<CR>",
				desc = "find marks",
			},
		},
		config = function()
			require("telescope").load_extension("harpoon")
		end,
	},

}
