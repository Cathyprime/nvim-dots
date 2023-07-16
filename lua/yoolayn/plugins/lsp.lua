return {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v2.x',
	dependencies = {
		-- LSP Support
		{'neovim/nvim-lspconfig'},             -- Required
		{                                      -- Optional
			'williamboman/mason.nvim',
			build = function()
				pcall(vim.cmd, 'MasonUpdate')
			end,
		},
		{'williamboman/mason-lspconfig.nvim'}, -- Optional

		-- Autocompletion
		{'hrsh7th/nvim-cmp'},     -- Required
		{'hrsh7th/cmp-nvim-lsp'}, -- Required
		{'L3MON4D3/LuaSnip'},     -- Required
	},
	config = function()
		local lsp = require("lsp-zero")

		lsp.preset("recommended")

		lsp.ensure_installed({
			"eslint",
			"lua_ls",
			"rust_analyzer",
			"taplo",
			"tsserver",
		})

		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		local cmp_mappings = lsp.defaults.cmp_mappings({
			["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
			["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<C-Space>"] = cmp.mapping.complete(),
		})

		lsp.setup_nvim_cmp({
			mapping = cmp_mappings
		})

		lsp.on_attach(function(client, bufnr)

			vim.keymap.set("n", "<leader>lrn", function() vim.lsp.buf.rename() end, { bufnr = bufnr, remap = false, desc = "lsp rename" })
			vim.keymap.set("n", "<leader>lrr", function() vim.lsp.buf.references() end, { bufnr = bufnr, remap = false, desc = "references" })
			vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, { bufnr = bufnr, remap = false, desc = "signature help" })

		end)
		lsp.setup()
	end,
}
