require("mini.deps").add({
    source = "williamboman/mason-lspconfig.nvim",
    depends = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
    },
})

require("mini.deps").now(function()
    require("cathy.config.lsp")
end)
