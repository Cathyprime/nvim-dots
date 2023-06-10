return {
    "williamboman/mason.nvim",
    opts = {
        ensure_installed = {
            "stylua",
            "shfmt",
            "autopep8",
            "pyright",
            "clangd",
            "rust-analyzer",
            "rustfmt",
            "typescript-language-server",
        },
    },
}
