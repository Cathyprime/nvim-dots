local telescope_utils = require("util.telescope-utils")
local get_root = require("rooter").get_root

return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim",
        "stevearc/oil.nvim",
        {
            "nvim-telescope/telescope-file-browser.nvim",
            dependencies = "nvim-tree/nvim-web-devicons"
        },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build =
            "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
        },
    },
    config = function(_, opts)
        require("telescope").setup(opts)
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("file_browser")
    end,
    opts = function()
        local telescope_config = require("util.telescope-config")
        local actions = require("telescope.actions")
        local actions_state = require("telescope.actions.state")
        local fb_actions = require("telescope").extensions.file_browser.actions
        local oil = require("oil")

        local on_tab = function(prompt_bufnr)
            local current_picker = actions_state.get_current_picker(prompt_bufnr)
            local entry = current_picker:get_selection()
            if entry.is_dir then
                fb_actions.change_cwd(prompt_bufnr)
            else
                current_picker:set_prompt(vim.fn.fnamemodify(entry.value, ":t"))
            end
        end

        local on_cr = function(prompt_bufnr)
            local current_picker = actions_state.get_current_picker(prompt_bufnr)
            local entry = current_picker:get_selection()
            if entry == nil then
                local prompt = current_picker:_get_prompt()
                actions.close(prompt_bufnr)
                vim.cmd(string.format("edit %s", prompt))
            elseif entry.is_dir then
                actions.close(prompt_bufnr)
                oil.open(entry.value)
            else
                actions.select_default(prompt_bufnr)
            end
        end
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
        return {
            defaults = vim.tbl_deep_extend("force", require("telescope.themes").get_ivy(), defaults),
            pickers = {
                buffers = {
                    mappings = {
                        i = {
                            ["<m-d>"] = "delete_buffer",
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
                        n = {
                            ["<Tab>"] = on_tab,
                            ["<CR>"] = on_cr,
                        },
                        i = {
                            ["<Tab>"] = on_tab,
                            ["<CR>"] = on_cr,
                        },
                    }
                }
            }
        }
    end,
    keys = {
        { "<leader>fw",       telescope_utils.get_word,                   desc = "cursor grep" },
        {
            "<c-p>",
            function()
                require("telescope.builtin").find_files({
                    file_ignore_patterns = require("util.telescope-config").ignores,
                    hidden = true,
                    cwd = get_root(true)
                })
            end,
            desc = "files"
        },
        { "<leader>fF",       require("telescope.builtin").resume,        desc = "resume" },
        { "<leader>fs",       require("telescope.builtin").treesitter,    desc = "treesitter" },
        { "<leader>fd",       require("telescope.builtin").diagnostics,   desc = "diagnostics" },
        -- { "<leader><leader>", require("telescope.builtin").buffers,       desc = "buffers" },
        { "<m-x>",            require("telescope.builtin").commands,      desc = "commands" },
        { "<leader>fo",       require("telescope.builtin").oldfiles,      desc = "oldfiles" },
        { "<leader>fh",       require("telescope.builtin").help_tags,     desc = "help" },
        -- { "<leader>fp",       telescope_utils.change_dir,                 desc = "project files" },
        { "<leader>fg",       require("telescope.builtin").live_grep,     desc = "grep" },
        { "z=",               require("telescope.builtin").spell_suggest, desc = "spell suggestion" },
        {
            "<leader>fn",
            function()
                require("telescope.builtin").find_files({
                    cwd = "~/.config/nvim"
                })
            end,
            desc = "config files"
        },
        {
            "<leader>fG",
            function()
                require("telescope.builtin").live_grep({
                    search_dirs = { vim.fn.expand("%:p") },
                })
            end,
            desc = "grep current file"
        },
        {
            "<leader>ff",
            function()
                require("telescope").extensions.file_browser.file_browser({
                    hide_parent_dir = true,
                    create_from_prompt = false,
                    no_ignore = true,
                    quiet = true,
                    cwd = (function()
                        local pph = vim.fn.expand("%:p:h")
                        local cwd = vim.fn.getcwd()
                        if string.find(pph, cwd) then
                            return cwd
                        else
                            return pph
                        end
                    end)()
                })
            end,
            desc = "projects"
        }
    }
}
