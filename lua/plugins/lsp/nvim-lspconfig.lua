return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
		{ "folke/neodev.nvim", opts = {} },
		"mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{
			"hrsh7th/cmp-nvim-lsp",
			cond = function()
				return require("yoolayn.util.funcs").has("nvim-cmp")
			end,
		},
	},
	---@class PluginLspOpts
	opts = {
		diagnostics = {
			underline = true,
			update_in_insert = false,
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
			},
			severity_sort = true,
		},
		inlay_hints = {
			enabled = false, -- configure the server itself to work properly, along with this setting
		},
		capabilities = {}, -- global capabilities (work on any server)
		autoformat = true,
		format_notify = false, -- Notify which formater does the formatting
		format = {
			formatting_options = nil,
			timeout_ms = nil,
		},
		-- LSP Server Settings
		---@diagnostic disable-next-line
		---@type lspconfig.options
		servers = {
			jsonls = {},
			lua_ls = {
				---@diagnostic disable-next-line
				---@type LazyKeys[]
				-- keys = {},
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
			clangd = {
				keys = {
					{
						"<leader>cR",
						"<cmd>ClangdSwitchSourceHeader<cr>",
						desc = "Switch Source/Header (C/C++)",
					},
				},
				root_dir = function(...)
					return require("lspconfig.util").root_pattern(
						"compile_commands.json",
						"compile_flags.txt",
						"configure.ac",
						".git"
					)(...)
				end,
				capabilities = {
					offsetEncoding = { "utf-16" },
				},
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
					"--fallback-style=llvm",
				},
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
					clangdFileStatus = true,
				},
			},
			rust_analyzer = {
				keys = {
					{ "K", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
					{ "<leader>cR", "<cmd>RustCodeAction<cr>", desc = "Code Action (Rust)" },
					{ "<leader>dr", "<cmd>RustDebuggables<cr>", desc = "Run Debuggables (Rust)" },
				},
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							runBuildScripts = true,
						},
						-- Add clippy lints for Rust.
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
			},
			taplo = {
				keys = {
					{
						"K",
						function()
							if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
								require("crates").show_popup()
							else
								vim.lsp.buf.hover()
							end
						end,
						desc = "Show Crate Documentation",
					},
				},
			},
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
			clangd = function(_, opts)
				local clangd_ext_opts = require("yoolayn.util.funcs").opts("clangd_extensions.nvim")
				require("clangd_extensions").setup(
					vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts })
				)
				return true
			end,
			rust_analyzer = function(_, opts)
				local rust_tools_opts = require("yoolayn.util.funcs").opts("rust-tools.nvim")
				require("rust-tools").setup(vim.tbl_deep_extend("force", rust_tools_opts or {}, { server = opts }))
				return true
			end,
			tsserver = function(_, opts)
				require("typescript").setup({ server = opts })
				return true
			end,
		},
	},
	config = function(_, opts)
		local Util = require("yoolayn.util.funcs")
		-- setup autoformat
		require("yoolayn.util.lsp.format").setup(opts)
		-- setup formatting and keymaps
		Util.on_attach(function(client, buffer)
			require("yoolayn.util.lsp.keymaps").on_attach(client, buffer)
		end)

		local register_capability = vim.lsp.handlers["client/registerCapability"]

		---@diagnostic disable-next-line
		vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
			local ret = register_capability(err, res, ctx)
			local client_id = ctx.client_id
			---@type lsp.Client
			local client = vim.lsp.get_client_by_id(client_id)
			local buffer = vim.api.nvim_get_current_buf()
			require("yoolayn.util.lsp.keymaps").on_attach(client, buffer)
			return ret
		end

		-- diagnostics
		for name, icon in pairs(require("yoolayn.data.icons").diagnostics) do
			name = "DiagnosticSign" .. name
			vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
		end

		local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

		if opts.inlay_hints.enabled and inlay_hint then
			Util.on_attach(function(client, buffer)
				if client.server_capabilities.inlayHintProvider then
					inlay_hint(buffer, true)
				end
			end)
		end

		if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
			opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
				or function(diagnostic)
					local icons = require("yoolayn.data.icons").diagnostics
					for d, icon in pairs(icons) do
						if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
							return icon
						end
					end
				end
		end

		vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

		local servers = opts.servers
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities(),
			opts.capabilities or {}
		)

		local function setup(server)
			local server_opts = vim.tbl_deep_extend("force", {
				capabilities = vim.deepcopy(capabilities),
			}, servers[server] or {})

			if opts.setup[server] then
				if opts.setup[server](server, server_opts) then
					return
				end
			elseif opts.setup["*"] then
				if opts.setup["*"](server, server_opts) then
					return
				end
			end
			require("lspconfig")[server].setup(server_opts)
		end

		-- get all the servers that are available thourgh mason-lspconfig
		local have_mason, mlsp = pcall(require, "mason-lspconfig")
		local all_mslp_servers = {}
		if have_mason then
			all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
		end

		local ensure_installed = {} ---@type string[]
		for server, server_opts in pairs(servers) do
			if server_opts then
				server_opts = server_opts == true and {} or server_opts
				-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
				if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
					setup(server)
				else
					ensure_installed[#ensure_installed + 1] = server
				end
			end
		end

		if have_mason then
			mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
		end

		if Util.lsp_get_config("denols") and Util.lsp_get_config("tsserver") then
			local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
			Util.lsp_disable("tsserver", is_deno)
			Util.lsp_disable("denols", function(root_dir)
				return not is_deno(root_dir)
			end)
		end
	end,
}
