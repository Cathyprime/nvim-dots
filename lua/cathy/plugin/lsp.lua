require("mini.deps").add({
    source = "williamboman/mason-lspconfig.nvim",
    depends = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
    },
})

require("cathy.config.lsp")
