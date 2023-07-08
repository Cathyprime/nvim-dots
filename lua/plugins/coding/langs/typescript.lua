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
	-- typescript
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
	-- eslint
	{
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					eslint = {
						settings = {
							workingDirectory = { mode = "auto" },
						},
					},
				},
				setup = {
					eslint = function()
						vim.api.nvim_create_autocmd("BufWritePre", {
							callback = function(event)
								if not require("yoolayn.util.lsp.format").enabled() then
									return
								end

								local client = vim.lsp.get_active_clients({ bufnr = event.buf, name = "eslint" })[1]
								if client then
									local diag = vim.diagnostic.get(
										event.buf,
										{ namespace = vim.lsp.diagnostic.get_namespace(client.id) }
									)
									if #diag > 0 then
										vim.cmd("EslintFixAll")
									end
								end
							end,
						})
					end,
				},
			},
		},
	},
}
