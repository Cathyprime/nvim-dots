
return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
        },
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-file-browser.nvim",
        }
    },
    config = function()
        local telescope_config = require("util.telescope-config")

        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")
        local defaults = {
            borderchars = telescope_config.borderchars,
            border = telescope_config.border,
            mappings = {
                i = {
                    ["<C-q>"] = function(...)
                        return actions.smart_send_to_qflist(...)
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
                            ["<m-d>"] = "delete_buffer"
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
                },
                file_browser = {
                    mappings = {
                        i = {
                            ["<c-t>"] = function(prompt_bufnr)
                                vim.cmd "silent Rooter disable"
                                require("telescope._extensions.file_browser.actions").change_cwd(prompt_bufnr)
                                vim.cmd "Rooter cwd"
                            end
                        },
                        n = {
                            ["t"] = function(prompt_bufnr)
                                vim.cmd "silent Rooter disable"
                                require("telescope._extensions.file_browser.actions").change_cwd(prompt_bufnr)
                                vim.cmd "Rooter cwd"
                            end
                        }
                    }
                }
            }
        })

        vim.keymap.set("n", "<leader>ff", function()
            require("telescope.builtin").find_files({
                file_ignore_patterns = telescope_config.ignores,
                hidden = true,
            })
        end, { desc = "files" })

        local get_nvim = function()
            builtin.find_files({
                cwd = "~/.config/nvim"
            })
        end

        local get_word = function()
            builtin.grep_string({ search = vim.fn.expand("<cword>") })
        end

        vim.keymap.set("n", "<leader>fw",       get_word, { desc = "cursor grep" })
        vim.keymap.set("n", "<leader>fF",       builtin.resume, { desc = "resume" })
        vim.keymap.set("n", "<leader>fs",       builtin.treesitter, { desc = "treesitter" })
        vim.keymap.set("n", "<leader>fd",       builtin.diagnostics, { desc = "diagnostics" })
        vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "buffers" })
        vim.keymap.set("n", "<m-x>",            builtin.commands, { desc = "commands" })
        vim.keymap.set("n", "<leader>fo",       builtin.oldfiles, { desc = "oldfiles" })
        vim.keymap.set("n", "<leader>fh",       builtin.help_tags, { desc = "help" })
        vim.keymap.set("n", "<leader>fg",       builtin.live_grep, { desc = "grep" })
        vim.keymap.set("n", "z=",               builtin.spell_suggest, { desc = "spell suggestion" })
        vim.keymap.set("n", "<leader>fn",       get_nvim, { desc = "config files" })
        vim.keymap.set("n", "<leader>fG", function()
            require("telescope.builtin").live_grep( {
                search_dirs = { vim.fn.expand("%:p") },
            })
        end, { desc = "grep current file" })

        -- vim.keymap.set("n", "<c-p>",      telescope_utils.project_files, { desc = "project files" })
        vim.keymap.set("n", "<c-p>", function()
            require("telescope").extensions.file_browser.file_browser({
                hide_parent_dir = true,
                create_from_prompt = false,
                no_ignore = true,
                quiet = true,
            })
        end, { desc = "projects" })
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("file_browser")
    end,
    keys = { "<leader>f" }
}
