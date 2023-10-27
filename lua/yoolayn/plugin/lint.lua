return {
	"mfussenegger/nvim-lint",
	event = {"BufReadPre", "BufNewFile"},
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			lua = { "luacheck" },
			go = { "golangcilint" },
			python = { "mypy", "ruff" },
			javascript = { "elint_d" },
			typescript = { "elint_d" },
			javascriptreact = { "elint_d" },
			typescriptreact = { "elint_d" },
		}

		require("lint").linters.luacheck.args = {
			args = {
				"--formatter",
				"plain",
				"--globals",
				"vim",
				"--codes",
				"--ranges",
				"-"
			},
		 }

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({
			"BufEnter",
			"BufWritePost",
			"InsertLeave"
		}, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end
		})
	end
}
