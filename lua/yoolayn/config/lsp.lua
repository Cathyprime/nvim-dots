local lspconfig = require "lspconfig"

local function on_attach(client, bufnr)
	local opts = { buffer = bufnr }
	vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>",         opts)
	vim.keymap.set("n", "gI",         "<cmd>Telescope lsp_implementations<CR>",    opts)
	vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end,    opts)
	vim.keymap.set("n", "<leader>cc", function() vim.lsp.buf.rename() end,         opts)
	vim.keymap.set("i", "<c-h>",      function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set("n", "[d",         function() vim.diagnostic.goto_prev() end,   opts)
	vim.keymap.set("n", "]d",         function() vim.diagnostic.goto_next() end,   opts)
	vim.keymap.set("n", "gd",         function() vim.lsp.buf.definition() end,     opts)

	vim.api.nvim_buf_set_option(bufnr,"completefunc", "v:lua.vim.lsp.omnifunc")
	vim.api.nvim_buf_set_option(bufnr,"formatexpr",   "v:lua.vim.lsp.formatexpr()")
	if client.server_capabilities.definitionProvider then
		vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
	end
end

local default_setup = function(server)
	lspconfig[server].setup({
		on_attach = on_attach,
	})
end

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"bashls",
		"jsonls",
		"lua_ls",
		"pylsp",
		"rust_analyzer",
		"tsserver",
		"yamlls",
	},
	handlers = {
		default_setup,
		tsserver = function()
			require("lspconfig").tsserver.setup({
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
				}
			})
		end,
		rust_analyzer = function()
			require("lspconfig").rust_analyzer.setup({
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							runBuildScripts = true,
						},
						checkOnSave = {
							allFeatures = true,
							command = "clippy",
							extraArgs = { "--no-deps" },
						},
						procMacro = {
							enable = true,
							ignored = {
								["async-trait"] = { "async_trait" },
								["napi-derive"] = { "napi" },
								["async-recursion"] = { "async_recursion" },
							},
						},
					},
				}
			})
		end
	}
})
