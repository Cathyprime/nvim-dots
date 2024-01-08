local telescope_config = require("util.telescope-config")

return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    config = function()
        local actions = require("telescope.actions")
        local defaults = {
            borderchars = telescope_config.borderchars,
            layout_config = telescope_config.layout_config,
            border = telescope_config.border,
            mappings = {
                i = {
                    ["<C-l>"] = function(...)
                        return actions.smart_send_to_loclist(...)
                    end,
                    ["<C-q>"] = function(...)
                        return actions.smart_send_to_qflist(...)
                    end,
                    ["<C-u>"] = false,
                    ["<C-e>"] = function(...)
                        return actions.preview_scrolling_down(...)
                    end,
                    ["<C-y>"] = function(...)
                        return actions.preview_scrolling_up(...)
                    end,
                },
            },
        }
        defaults = vim.tbl_deep_extend("force", require("telescope.themes").get_ivy(), defaults)
        require("telescope").setup({
            defaults = defaults,
            pickers = {
                buffers = {
                    mappings = {
                        i = {
                            ["<c-d>"] = "delete_buffer"
                        }
                    }
                }
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            }
        })
        require("telescope").load_extension("fzf")
    end,
    keys = {
        {
            "<leader>ff",
            function() require("telescope.builtin").find_files({
                file_ignore_patterns = {
                    "node%_modules/*",
                    "venv/*",
                    "%.git/*",
                    "%.mypy_cache/",
                },
                hidden = true,
            }) end
        },
        { "<leader>fF", require("telescope.builtin").resume },
        { "<leader>fo", function() require("telescope.builtin").oldfiles() end },
        { "<leader>fb", function() require("telescope.builtin").buffers() end },
        { "<leader><leader>", function() require("telescope.builtin").buffers() end },
        { "<leader>fh", function() require("telescope.builtin").help_tags() end },
        { "<leader>fg", function() require("telescope.builtin").live_grep() end },
        { "<leader>fp", telescope_config.change_dir },
        {
            "<leader>fG",
            function()
                require("telescope.builtin").live_grep({
                    search_dirs = { vim.fn.expand("%:p") },
                })
            end,
        },
        { "<c-p>", function() telescope_config.project_files() end },
    }
}
