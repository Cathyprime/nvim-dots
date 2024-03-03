require("mini.deps").add({
    source = "neovim/nvim-lspconfig",
    depends = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "j-hui/fidget.nvim",
        "nvim-telescope/telescope.nvim",
        "hrsh7th/nvim-cmp",
    }
})

require("mini.deps").later(function()
    require("cathy.config.lsp")
end)
