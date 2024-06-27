return {
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            require("cathy.config.cmp")
            require("cathy.config.luasnip")
            local colors = require("cathy.config.cmp-colors")
            colors.run(false)
            colors.set_autocmd()
        end,
        event = { "InsertEnter" }
    }
}
