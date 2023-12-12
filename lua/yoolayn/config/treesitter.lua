---@diagnostic disable-next-line
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"c",
		"cmake",
		"commonlisp",
		"cpp",
		"diff",
		"fish",
		"gitattributes",
		"gitcommit",
		"git_config",
		"gitignore",
		"git_rebase",
		"go",
		"html",
		"javascript",
		"json",
		"json5",
		"jsonc",
		"lua",
		"luadoc",
		"luap",
		"markdown",
		"markdown_inline",
		"ninja",
		"norg",
		"python",
		"query",
		"r",
		"regex",
		"ron",
		"rst",
		"rust",
		"scala",
		"scss",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"vimdoc",
		"yaml",
		"yuck",
		"zig",
	},
	context_commentstring = { enabled = true },
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			node_incremental = "<c-w>",
			node_decremental = "<c-e>",
			scope_incremental = "<c-s>",
		}
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,

			keymaps = {
				["af"] = { query = "@function.outer", desc = "select a functions" },
				["if"] = { query = "@function.inner", desc = "select inner functions" },
				["ac"] = { query = "@class.outer", desc = "select a class" },
				["ic"] = { query = "@class.inner", desc = "select inner class" },
				["aa"] = { query = "@parameter.outer", desc = "select a argument" },
				["ia"] = { query = "@parameter.inner", desc = "select inner argument" },
				["il"] = { query = "@loop.inner", desc = "select a loop" },
				["al"] = { query = "@loop.outer", desc = "select inner loop" },
				["at"] = { query = "@comment.outer", desc = "select a comment" },
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]l"] = "@loop.outer",
				["]]"] = "@function.outer",
			},
			goto_next_end = {
				["]L"] = "@loop.outer",
				["]["] = "@function.outer",
			},
			goto_previous_start = {
				["[l"] = "@loop.outer",
				["[["] = "@function.outer",
			},
			goto_previos_end = {
				["[L"] = "@loop.outer",
				["[]"] = "@function.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["g>"] = "@parameter.inner",
			},
			swap_previous = {
				["g<"] = "@parameter.inner",
			}
		}
	}
})

