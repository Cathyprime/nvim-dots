return {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
        local cmp = require("cmp")

        opts.mapping = vim.tbl_extend("force", opts.mapping, {
            ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        })
        opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
            { name = "org" },
        }))
    end,
}
