require("mini.deps").add({
    source = "neovim/nvim-lspconfig",
    depends = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "j-hui/fidget.nvim",
        "nvim-telescope/telescope.nvim",
    }
})

require("mini.deps").later(function()
    require("yoolayn.config.lsp")
end)
