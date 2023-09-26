local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		install = {
			missing = false,
		},
		checker = {
			enabled = false,
		},
		change_detection = {
			notify = false
		},
		-- {import = "plugin"}
		-- telescope stuff
		{
			'nvim-telescope/telescope.nvim',
			tag = '0.1.2',
			dependencies = { 'nvim-lua/plenary.nvim' },
		},

		-- colorscheme
		"rebelot/kanagawa.nvim",

		-- helpers for editing
		"cohama/lexima.vim",
		{
			"numToStr/Comment.nvim",
			opts = {},
		},
		{
			"kylechui/nvim-surround",
			tag = "*",
			opts = {},
		},
		{
			"mbbill/undotree",
			config = function ()
				vim.api.nvim_create_autocmd("VimEnter", {
					once = true,
					callback = function()
						vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", {silent = true})
					end
				})
			end
		},
		"anuvyklack/hydra.nvim" ,

		-- file management
		{
			"nvim-tree/nvim-tree.lua",
			dependencies = {"nvim-tree/nvim-web-devicons"},
			config = function()
				-- NOTE: i have no idea why, but without binding on VimEnter
				-- it does not bind at all
				vim.api.nvim_create_autocmd("VimEnter", {
					once = true,
					callback = function()
						vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { silent = true })
					end
				})
				require("nvim-tree").setup({
					filters = {
						dotfiles = true,
					}
				})
			end
		},
		"ThePrimeagen/harpoon",

		-- git integration
		"tpope/vim-fugitive",
		{
			"lewis6991/gitsigns.nvim",
			opts = {
				on_attach = function(bufnr)
					vim.keymap.set(
					{ "o", "x" },
					"ih",
					":<C-u>Gitsigns select_hunk<cr>",
					{
						desc = "inner hunk",
						buffer = bufnr
					})
				end,
			}
		},

		-- treesitter
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			dependencies = {
				"nvim-treesitter/nvim-treesitter-textobjects",
				"JoosepAlviste/nvim-ts-context-commentstring",
				"nvim-treesitter/playground",
			}
		},
		-- lsp
		{
			"VonHeikemen/lsp-zero.nvim",
			branch = "v2.x",
			dependencies = {
				-- LSP Support
				"neovim/nvim-lspconfig",			 -- Required
				"williamboman/mason.nvim",			 -- Optional
				"williamboman/mason-lspconfig.nvim", -- Optional

				-- Autocompletion
				"hrsh7th/nvim-cmp",		-- Required
				"hrsh7th/cmp-nvim-lsp", -- Required
				"L3MON4D3/LuaSnip",		-- Required
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-nvim-lua",
				"octaltree/cmp-look",
				"hrsh7th/cmp-path",
				{
					"dgagn/diagflow.nvim",
					opts = {scope = "line"}
				},
			},
		},
		{
			"j-hui/fidget.nvim",
			tag = "legacy",
			opts = {
				text = { spinner = "moon" },
				window = { blend = 0 }
			}
		},
		{
			"scalameta/nvim-metals",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				local lsp_zero = require('lsp-zero')
				local metals_config = require('metals').bare_config()
				metals_config.capabilities = lsp_zero.get_capabilities()
				local nvim_metals_group =
				vim.api.nvim_create_augroup("nvim-metals", { clear = true })
				vim.api.nvim_create_autocmd("FileType", {
					pattern = { "scala", "sbt", "java" },
					callback = function()
						require("metals").initialize_or_attach({})
						local metals_config = require("metals").bare_config()
						metals_config.settings = {
							showImplicitArguments = true,
							serverVersion = "latest.snapshot",
						}
						metals_config.init_options.statusBarProvider = "on"
					end,
					group = nvim_metals_group,
				})
			end
		},

		-- ui
		{
			"folke/todo-comments.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			event = "VimEnter",
			opts = {},
		},

		-- lispy stuff (love lisp btw)
		{"eraserhd/parinfer-rust",
		build = "cargo build --release",
		ft = { "lisp", "yuck" }},
		{"elkowar/yuck.vim",
		ft = "yuck"},

		-- misc
		"ThePrimeagen/vim-be-good",
		"tpope/vim-dispatch",
		"godlygeek/tabular",
		"tpope/vim-eunuch",
		"stefandtw/quickfix-reflector.vim",
	}
})
