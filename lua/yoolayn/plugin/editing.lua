return {
	{
		"numToStr/Comment.nvim",
		event = {"BufEnter", "BufReadPre"},
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		event = { "BufNewFile", "BufReadPost", "InsertEnter" },
		opts = {
			keymaps = {
				insert = "<c-s>",
				insert_line = "<c-s><c-s>",
			}
		}
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		dependencies = "hrsh7th/nvim-cmp",
		config = function()
			require("nvim-autopairs").setup({})
			require("nvim-autopairs").remove_rule('"')
			require("nvim-autopairs").remove_rule("'")
			require("nvim-autopairs").remove_rule('`')
			require("nvim-autopairs").remove_rule('(')
			require("nvim-autopairs").remove_rule('[')
			require("nvim-autopairs").remove_rule('{')
			require("yoolayn.config.cmp-pairs")
			require("yoolayn.config.pair-customrules")
		end
	},
	{
		"nvim-pack/nvim-spectre",
		opts = {},
		keys = {
			{
				"<leader>rr",
				"<cmd>lua require('spectre').toggle()<cr>"
			}
		}
	},
	{
		"cshuaimin/ssr.nvim",
		config = true,
		keys = {
			{
				"<leader>rs",
				"<cmd>lua require('ssr').open()<cr>"
			}
		}
	},
	{
		"Wansmer/treesj",
		opts = {
			use_default_keymaps = false,
			max_join_length = 160,
		},
		keys = {
			{
				"gs",
				function()
					require("treesj").toggle()
				end,
			},
		},
	}
}
