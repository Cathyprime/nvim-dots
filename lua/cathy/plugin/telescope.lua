local telescope_utils = require("util.telescope-utils")

local find_files = function()
    require("telescope.builtin").find_files({
        file_ignore_patterns = require("util.telescope-config").ignores,
        hidden = true,
    })
end

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
        require("telescope").load_extension("projects")
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
                if prompt:match("/$") then
                    fb_actions.create_from_prompt(prompt_bufnr)
                else
                    actions.close(prompt_bufnr)
                    vim.cmd(string.format("edit %s", prompt))
                end
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
                },
                projects = {
                    mappings = {
                        i = {
                            ["<c-f>"] = find_files
                        },
                        n = {
                            ["f"] = find_files
                        },
                    }
                },
            }
        }
    end,
    keys = {
        { "<leader>fw",       telescope_utils.get_word,                                           desc = "cursor grep" },
        { "<c-p>",            find_files,                                                         desc = "files" },
        { "<leader>fF",       function() require("telescope.builtin").resume() end,               desc = "resume" },
        { "<leader>fs",       function() require("telescope.builtin").treesitter() end,           desc = "treesitter" },
        { "<leader>fd",       function() require("telescope.builtin").diagnostics() end,          desc = "diagnostics" },
        -- { "<leader><leader>", require("telescope.builtin").buffers,       desc = "buffer       s" },
        { "<m-x>",            function() require("telescope.builtin").commands() end,             desc = "commands" },
        { "<leader>fo",       function() require("telescope.builtin").oldfiles() end,             desc = "oldfiles" },
        { "<leader>fh",       function() require("telescope.builtin").help_tags() end,            desc = "help" },
        { "<leader>fp",       function() require("telescope").extensions.projects.projects() end, desc = "project files" },
        { "<leader>fg",       function() require("telescope.builtin").live_grep() end,            desc = "grep" },
        { "z=",               function() require("telescope.builtin").spell_suggest() end,        desc = "spell suggestion" },
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
