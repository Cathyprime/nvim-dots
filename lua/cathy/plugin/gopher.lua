local setup = {
    go = "go",
    gomodifytags = "gomodifytags",
    gotests = "gotests",
    impl = "impl",
    iferr = "iferr",
}

require("mini.deps").add({
    source = "olexsmir/gopher.nvim",
    depends = {
        -- "nvim-lua/plenary.nvim", installed by lua rocks
        "nvim-treesitter/nvim-treesitter",
    },
})

require("mini.deps").later(function()
    require("gopher").setup(setup)
end)
