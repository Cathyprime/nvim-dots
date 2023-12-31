return {
    "mfussenegger/nvim-lint",
    event = {"BufReadPre", "BufNewFile"},
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            lua = { "luacheck" },
            go = { "golangcilint" },
            python = { "mypy", "ruff" },
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
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
        vim.keymap.set("n", "<leader>tl", function()
            vim.api.nvim_clear_autocmds({
                group = lint_augroup
            })
            vim.diagnostic.reset(nil, 0)
        end)
    end
}
