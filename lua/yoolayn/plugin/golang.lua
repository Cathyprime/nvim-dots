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
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    hooks = {
        post_install = function()
            require("gopher").setup(setup)
            vim.cmd("GoInstallDeps")
        end
    }
})

require("mini.deps").later(function()
    vim.api.nvim_create_autocmd("Filetype", {
        pattern = "go",
        once = false,
        callback = function()
            require("gopher").setup(setup)
        end
    })
end)
