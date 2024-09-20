return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
        "deathbeam/lspecho.nvim",
    },
    config =  function()
        require("cathy.config.lsp")
        require("lspecho").setup()
    end,
    event = "VeryLazy",
}
