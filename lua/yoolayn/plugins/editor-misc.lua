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
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {},
	},
	{
		"echasnovski/mini.surround",
		keys = function(_, keys)
			-- Populate the keys based on the user's options
			local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local mappings = {
				{ opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
				{ opts.mappings.delete, desc = "Delete surrounding" },
				{ opts.mappings.find, desc = "Find right surrounding" },
				{ opts.mappings.find_left, desc = "Find left surrounding" },
				{ opts.mappings.highlight, desc = "Highlight surrounding" },
				{ opts.mappings.replace, desc = "Replace surrounding" },
				{ opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
			}
			mappings = vim.tbl_filter(function(m)
				return m[1] and #m[1] > 0
			end, mappings)
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				add = "gza", -- Add surrounding in Normal and Visual modes
				delete = "gzd", -- Delete surrounding
				find = "gzf", -- Find surrounding (to the right)
				find_left = "gzF", -- Find surrounding (to the left)
				highlight = "gzh", -- Highlight surrounding
				replace = "gzr", -- Replace surrounding
				update_n_lines = "gzn", -- Update `n_lines`
			},
		},
	},

}
