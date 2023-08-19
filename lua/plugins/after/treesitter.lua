return {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync" },
    keys = {
        {
            "<leader>j",
            function () require("treesj").toggle() end,
            { desc = "toggle join/split" }
        },
        {
            "<leader>C",
            ":TSContextToggle<cr>",
            { desc = "toggle context", silent = true}
        },
    },
    config = function () require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "bash",
            "c",
            "cmake",
            "comment",
            "commonlisp",
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
            "yuck",
            "zig",
        },
        context_commentstring = { enabled = false },
        sync_install = false,
        highlight = { enable = true },
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
    })
    end,
    dependencies = {
        { "nvim-treesitter/nvim-treesitter-textobjects" },
        { "JoosepAlviste/nvim-ts-context-commentstring" },
        { "nvim-treesitter/nvim-treesitter-context",
            config = function()
                require("treesitter-context").setup()
            end
        },
        {"Wansmer/treesj",
        config = function() require("treesj").setup({ use_default_keymaps = false, max_join_lines = 150 }) end },
        {"nvim-treesitter/playground"},
    }
}

