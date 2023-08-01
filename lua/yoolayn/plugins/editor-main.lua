return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-d>"] = function(...)
                                return require("telescope.actions").preview_scrolling_down(
                                    ...
                                )
                            end,
                            ["<C-u>"] = function(...)
                                return require("telescope.actions").preview_scrolling_up(
                                    ...
                                )
                            end,
                            ["<C-j>"] = function(...)
                                return require("telescope.actions").move_selection_next(
                                    ...
                                )
                            end,
                            ["<C-k>"] = function(...)
                                return require("telescope.actions").move_selection_previous(
                                    ...
                                )
                            end,
                            ["<C-t>"] = require("trouble.providers.telescope").open_with_trouble,
                        },
                        n = {
                            ["<C-t>"] = require("trouble.providers.telescope").open_with_trouble,
                        },
                    },
                },
            })
        end,
        -- stylua: ignore
        keys = {
            -- general
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "find files", },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "find recent files" },
            { "<leader>fp", function() require("telescope.builtin").builtin() end, desc = "find pickers" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "find Buffers" },
            { "<leader>fh", function ()
                local vhelp = vim.api.nvim_create_augroup("Vertical Help", {})
                vim.api.nvim_create_autocmd("BufEnter", {
                    group = vhelp,
                    callback = function ()
                        if vim.bo.filetype == "help" then
                            vim.cmd("wincmd L")
                            vim.api.nvim_clear_autocmds({group = vhelp})
                        end
                    end
                })
                require("telescope.builtin").help_tags()
            end, desc = "vertical help tags" },
            { "<leader>fH", function ()
                if next(vim.api.nvim_get_autocmds({group = "Vertical Help"})) ~= nil then
                    vim.api.nvim_clear_autocmds({ group = "Vertical Help" })
                end
                require("telescope.builtin").help_tags()
            end, desc = "help tags" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "live grep", },
            {
                "<leader>fG",
                function()
                    require("telescope.builtin").live_grep({
                        search_dirs = { vim.fn.expand("%:p") },
                    })
                end,
                desc = "live grep current file",
            },
            { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "find keymaps", },
            { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "find marks" },
            {
                "<leader>fs",
                function()
                    require("telescope.builtin").lsp_document_symbols({
                        symbols = {
                            "Class",
                            "Function",
                            "Method",
                            "Constructor",
                            "Interface",
                            "Module",
                            "Struct",
                            "Trait",
                            "Field",
                            "Property",
                        },
                    })
                end,
                desc = "find symbols",
            },

            -- git
            { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "find git files", },
            { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "git status", },
            { "<leader>gS", "<cmd>Telescope git_stash<cr>", desc = "git stash", },
            { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "git commits", },
            { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "git branches", },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = "<cmd>TSUpdate<cr>",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-context",
        },
        keys = {
            { "<c-space>", desc = "Increment selection" },
            { "<bs>", desc = "Decrement selection", mode = "x" },
        },
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "bash",
                "c",
                "html",
                "javascript",
                "json",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            },
        },
        config = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                local added = {}
                opts.ensure_installed = vim.tbl_filter(function(lang)
                    if added[lang] then
                        return false
                    end
                    added[lang] = true
                    return true
                end, opts.ensure_installed)
            end
            require("nvim-treesitter.configs").setup(opts)

            if load_textobjects then
                if opts.textobjects then
                    for _, mod in ipairs({
                        "move",
                        "select",
                        "swap",
                        "lsp_interop",
                    }) do
                        if
                            opts.textobjects[mod]
                            and opts.textobjects[mod].enable
                        then
                            local Loader = require("lazy.core.loader")
                            Loader.disabled_rtp_plugins["nvim-treesitter-textobjects"] =
                                nil
                            local plugin =
                                require("lazy.core.config").plugins["nvim-treesitter-textobjects"]
                            require("lazy.core.loader").source_runtime(
                                plugin.dir,
                                "plugin"
                            )
                            break
                        end
                    end
                end
            end
        end,
    },
}
