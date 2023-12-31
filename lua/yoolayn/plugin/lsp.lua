return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufEnter", "BufReadPost" },
        dependencies = {
            { "folke/neodev.nvim", opts = {} },
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "j-hui/fidget.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("yoolayn.config.lsp")
        end,
    },
}
