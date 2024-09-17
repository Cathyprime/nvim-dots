require("treesitter-context").setup({
    max_lines = 3
})

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
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "vimdoc",
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = false,
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
            include_surrounding_whitespace = true,
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
                ["]l"] = { query = "@loop.outer", desc = "Goto next start loop" },
                ["]]"] = { query = "@function.outer", desc = "Goto next start function" },
            },
            goto_next_end = {
                ["]L"] = { query = "@loop.outer", desc = "Goto next end loop" },
                ["]["] = { query = "@function.outer", desc = "Goto next end function" },
            },
            goto_previous_start = {
                ["[l"] = { query = "@loop.outer", desc = "Goto prev start loop" },
                ["[["] = { query = "@function.outer", desc = "Goto prev start function" },
            },
            goto_previos_end = {
                ["[L"] = { query = "@loop.outer", desc = "Goto prev end loop" },
                ["[]"] = { query = "@function.outer", desc = "Goto prev end function" },
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["g>"] = { query = { "@parameter.inner", "@call.outer", "@function.outer", "@class.outer" } },
            },
            swap_previous = {
                ["g<"] = { query = { "@parameter.inner", "@call.outer", "@function.outer", "@class.outer" } },
            }
        }
    }
})

