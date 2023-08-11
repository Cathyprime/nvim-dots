require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash",
        "c",
        "cmake",
        "comment",
        "cpp",
        "diff",
        "fish",
        "gitattributes",
        "gitcommit",
        "git_config",
        "git_config",
        "gitignore",
        "git_rebase",
        "go",
        "html",
        "javascript",
        "json",
        "json5",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "ninja",
        "norg",
        "python",
        "query",
        "regex",
        "ron",
        "rst",
        "rust",
        "scala",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        "zig",
    },
    context_commentstring = {
        enabled = true
    },
    sync_install = false,
    highlight = {
        enable = true,
    },
    additional_vim_regex_highlighting = false,
})
