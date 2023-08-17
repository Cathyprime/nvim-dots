local builtin = require("telescope.builtin")

return {
    "nvim-telescope/telescope.nvim",
    keys = {
        {
            "<leader>ff",
            "<cmd>Telescope find_files<cr>",
            {desc = "find files" },
        },
        {
            "<leader>fo",
            "<cmd>Telescope oldfiles<cr>",
            {desc = "find recent files" },
        },
        {
            "<leader>fp",
            function() builtin.builtin() end,
            {desc = "find pickers" },
        },
        {
            "<leader>fb",
            "<cmd>Telescope buffers<cr>",
            {desc = "find Buffers" },
        },
        {
            "<leader>fh",
            function () builtin.help_tags() end,
            {desc = "vertical help tags" },
        },

        {
            "<leader>fg",
            "<cmd>Telescope live_grep<cr>",
            {desc = "live grep" },
        },
        {
            "<leader>fG",
            function()
                builtin.live_grep({ search_dirs = { vim.fn.expand("%:p") } })
            end,
            {desc = "live grep current file" }
        },

        {
            "<leader>fk",
            "<cmd>Telescope keymaps<cr>",
            {desc = "find keymaps" },
        },
        {
            "<leader>fm",
            "<cmd>Telescope marks<cr>",
            {desc = "find marks" },
        },
        {
            "<leader>fs",
            function()
                builtin.lsp_document_symbols({
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
            {desc = "find symbols"}
        },

        -- git
        {
            "<c-p>",
            "<cmd>Telescope git_files<cr>",
            {desc = "find git files" },
        },
    },
    config = function ()
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
                    },
                },
            },
        })
    end
}


