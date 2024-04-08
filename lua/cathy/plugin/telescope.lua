local telescope_config = require("util.telescope-config")
local telescope_utils = require("util.telescope-utils")

require("mini.deps").add({
    source = "nvim-telescope/telescope-fzf-native.nvim",
    hooks = {
        post_checkout = function(opts)
            vim.system({ "make" }, { cwd = opts.path })
            require("telescope").load_extension("fzf")
        end
    }
})

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
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

vim.keymap.set("n", "<leader>ff", function()
    require("telescope.builtin").find_files( {
        file_ignore_patterns = {
            "node%_modules/*",
            "venv/*",
            "%.git/*",
            "%.mypy_cache/",
        },
        hidden = true,
    })
end)

local function get_nvim()
    require("telescope.builtin").find_files({
        cwd = "~/.config/nvim"
    })
end

vim.keymap.set("n", "<leader>fF",       builtin.resume)
vim.keymap.set("n", "<leader><leader>", builtin.buffers)
vim.keymap.set("n", "<m-x>",            builtin.commands)
vim.keymap.set("n", "<leader>fo",       builtin.oldfiles)
vim.keymap.set("n", "<leader>fh",       builtin.help_tags)
vim.keymap.set("n", "<leader>fg",       builtin.live_grep)
vim.keymap.set("n", "z=",               builtin.spell_suggest)
vim.keymap.set("n", "<leader>fn",       get_nvim)
vim.keymap.set("n", "<leader>fG", function()
    require("telescope.builtin").live_grep( {
        search_dirs = { vim.fn.expand("%:p") },
    })
end)

require("mini.deps").later(function()
    vim.keymap.set("n", "<c-p>",      telescope_utils.project_files)
    vim.keymap.set("n", "<leader>fp", telescope_utils.change_dir)
end)
