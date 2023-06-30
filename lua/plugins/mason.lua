return {
    "williamboman/mason.nvim",
    opts = {
        ensure_installed = {
            "stylua",
            "shfmt",
            "autopep8",
            "pyright",
            "typescript-language-server",
            "editorconfig-checker",
        },
    },
}
