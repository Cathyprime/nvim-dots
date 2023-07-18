return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "ninja", "python", "rst", "toml" })
			end
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				pyright = {},
				ruff_lsp = {},
			},
		},
		setup = {
			ruff_lsp = function()
				require("lazyvim.util").on_attach(function(client, _)
					if client.name == "ruff_lsp" then
						-- Disable hover in favor of Pyright
						client.server_capabilities.hoverProvider = false
					end
				end)
			end,
		},
	},
	{
		"linux-cultist/venv-selector.nvim",
		cmd = "VenvSelect",
		opts = {},
	},
}
