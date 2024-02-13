---@diagnostic disable-next-line
require("nvim-treesitter.configs").setup({
    auto_install = true,
    context_commentstring = { enabled = true },
    sync_install = false,
    ensure_installed = {
        "bash",
        "diff",
        "gitattributes",
        "gitcommit",
        "git_config",
        "gitignore",
        "git_rebase",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "javascript",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "typescript",
        "vimdoc",
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            node_incremental = "<c-w>",
            node_decremental = "<c-e>",
            scope_incremental = "<c-s>",
        }
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = { query = "@function.outer", desc = "select a functions" },
                ["if"] = { query = "@function.inner", desc = "select inner functions" },
                ["ac"] = { query = "@class.outer", desc = "select a class" },
                ["ic"] = { query = "@class.inner", desc = "select inner class" },
                ["aa"] = { query = "@parameter.outer", desc = "select a argument" },
                ["ia"] = { query = "@parameter.inner", desc = "select inner argument" },
                ["il"] = { query = "@loop.inner", desc = "select a loop" },
                ["al"] = { query = "@loop.outer", desc = "select inner loop" },
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]l"] = "@loop.outer",
                ["]]"] = "@function.outer",
            },
            goto_next_end = {
                ["]L"] = "@loop.outer",
                ["]["] = "@function.outer",
            },
            goto_previous_start = {
                ["[l"] = "@loop.outer",
                ["[["] = "@function.outer",
            },
            goto_previos_end = {
                ["[L"] = "@loop.outer",
                ["[]"] = "@function.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["g>"] = "@parameter.inner",
            },
            swap_previous = {
                ["g<"] = "@parameter.inner",
            }
        }
    }
})

