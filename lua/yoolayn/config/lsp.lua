local lspconfig = require "lspconfig"
local icons = require("util.icons").icons

vim.cmd([[sign define DiagnosticSignError text=]] .. icons.Error .. [[ texthl=DiagnosticSignError linehl= numhl= ]])
vim.cmd([[sign define DiagnosticSignWarn text=]] .. icons.Warning .. [[ texthl=DiagnosticSignWarn linehl= numhl= ]])
vim.cmd([[sign define DiagnosticSignInfo text=]] .. "i" .. [[ texthl=DiagnosticSignInfo linehl= numhl= ]])
vim.cmd([[sign define DiagnosticSignHint text=]] .. icons.Hint .. [[ texthl=DiagnosticSignHint linehl= numhl= ]])

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
				on_attach = on_attach,
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
		lua_ls = function()
			require("lspconfig").lua_ls.setup({
				on_attach = on_attach,
				on_init = function(client)
					local path = client.workspace_folders[1].name
					if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
						client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
							Lua = {
								runtime = {
									version = "LuaJIT",
								},
								workspace = {
									checkThirdParty = false,
									library = {
										vim.env.VIMRUNTIME,
										"${3rd}/luv/library",
										"${3rd}/busted/library",
									},
								},
							},
						})

						client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
					end
					return true
				end
			})
		end,
		rust_analyzer = function()
			require("lspconfig").rust_analyzer.setup({
				on_attach = on_attach,
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
				},
			})
		end
	}
})
require("mason-tool-installer").setup({
	ensure_installed = {
		"prettier",
		"stylua",
		"isort",
		"black",
		"ruff",
		"eslint_d",
		"gofumpt",
		"goimports",
		"golines",
		"luacheck",
		"golangci-lint",
		"mypy",
	},
})
