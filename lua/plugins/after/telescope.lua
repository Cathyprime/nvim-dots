local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", {desc = "find files" })
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", {desc = "find recent files" })
vim.keymap.set("n", "<leader>fp", function() require("telescope.builtin").builtin() end, {desc = "find pickers" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", {desc = "find Buffers" })
vim.keymap.set("n", "<leader>fh", function () require("telescope.builtin").help_tags() end, {desc = "vertical help tags" })

vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", {desc = "live grep" })
vim.keymap.set("n", "<leader>fG", function()
        require("telescope.builtin").live_grep({
            search_dirs = { vim.fn.expand("%:p") },
        })
    end,
    {desc = "live grep current file" })

vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", {desc = "find keymaps" })
vim.keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", {desc = "find marks" })
vim.keymap.set("n", "<leader>fs", function()
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
    {desc = "find symbols"})

-- git
vim.keymap.set("n", "<c-p>", "<cmd>Telescope git_files<cr>", {desc = "find git files" })

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
