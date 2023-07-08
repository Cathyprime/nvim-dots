return {
	{
		"jose-elias-alvarez/typescript.nvim",
		ft = "typescript",
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = function(_, opts)
			table.insert(opts.sources, require("typescript.extensions.null-ls.code-actions"))
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "jose-elias-alvarez/typescript.nvim" },
		opts = {
			-- make sure mason installs the server
			servers = {
				tsserver = {
					keys = {
						{ "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organize Imports" },
						{ "<leader>cR", "<cmd>TypescriptRenameFile<CR>", desc = "Rename File" },
					},
					settings = {
						typescript = {
							format = {
								indentSize = vim.o.shiftwidth,
								convertTabsToSpaces = vim.o.expandtab,
								tabSize = vim.o.tabstop,
							},
						},
						javascript = {
							format = {
								indentSize = vim.o.shiftwidth,
								convertTabsToSpaces = vim.o.expandtab,
								tabSize = vim.o.tabstop,
							},
						},
						completions = {
							completeFunctionCalls = true,
						},
					},
				},
			},
			setup = {
				tsserver = function(_, opts)
					require("typescript").setup({ server = opts })
					return true
				end,
			},
		},
	},
}
