return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>cf",
            function()
                require "conform".format({ async = true, lsp_fallback = true })
            end
        }
    },
    config = function()
        local conform = require("conform")
        local config = {
            formatters_by_ft = {
                go = { "gofumpt" },
                lua = { "stylua" },
                python = { "black" },
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescriptreact = { "prettierd" },
            },
        }

        conform.setup(config)
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
