return {
    "nvim-treesitter/nvim-treesitter",
    version = true,
    event = { "BufReadPost", "BufNewFile" },
    opts = {
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
        textobjects = {
            select = {
                enable = true,
                lookahead = true,

                keymaps = {
                    ["af"] = { query = "@function.outer", desc = "select a functions" },
                    ["if"] = { query = "@function.inner", desc = "select inner functions" },
                    ["ac"] = { query = "@class.outer", desc = "select a class" },
                    ["ic"] = { query = "@class.inner", desc = "select inner class" },
                    ["as"] = { query = "@scope", query_group = "locals", desc = "select language scope" },
                    ["aa"] = { query = "@parameter.outer", desc = "select a argument" },
                    ["ia"] = { query = "@parameter.inner", desc = "select inner argument" },
                },
                -- You can choose the select mode (default is charwise 'v')
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * method: eg 'v' or 'o'
                -- and should return the mode ('v', 'V', or '<c-v>') or a table
                -- mapping query_strings to modes.
                selection_modes = {
                    ['@parameter.outer'] = 'v', -- charwise
                    ['@function.outer'] = 'V', -- linewise
                    ['@class.outer'] = '<c-v>', -- blockwise
                },
                -- If you set this to `true` (default is `false`) then any textobject is
                -- extended to include preceding or succeeding whitespace. Succeeding
                -- whitespace has priority in order to act similarly to eg the built-in
                -- `ap`.
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * selection_mode: eg 'v'
                -- and should return true of false
                include_surrounding_whitespace = true,
            },
        }
    },
    config = function (opts)
        require("nvim-treesitter.configs").setup(opts)
        vim.keymap.set("n", "<leader>j", function () require("treesj").toggle() end, { desc = "toggle join/split" } )
    end,
    dependencies = {

        { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
        { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter/nvim-treesitter" } },
        { "JoosepAlviste/nvim-ts-context-commentstring", dependencies = { "nvim-treesitter/nvim-treesitter" } },
        { "nvim-treesitter/nvim-treesitter-context", dependencies = {"nvim-treesitter/nvim-treesitter"},
        config = function() require("treesitter-context").setup() end },
        {"Wansmer/treesj", dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function() require("treesj").setup({ _default_keymaps = false, }) end },
        {"nvim-treesitter/playground", dependencies = { "nvim-treesitter/nvim-treesitter" }},
    }
}

