local builtin = require "telescope.builtin"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local state   = require "telescope.actions.state"
local actions = require "telescope.actions"

local M = {}

local is_inside_work_tree = {}

M.project_files = function()
    local opts = {
        file_ignore_patterns = {
            "node%_modules/*",
            "venv/*",
            "%.mypy_cache/",
            "%.git/*",
        }
    }

    local cwd = vim.fn.getcwd()
    if is_inside_work_tree[cwd] == nil then
        vim.fn.system("git rev-parse --is-inside-work-tree")
        is_inside_work_tree[cwd] = vim.v.shell_error == 0
    end

    if is_inside_work_tree[cwd] then
        builtin.git_files()
    else
        builtin.find_files(opts)
    end
end

M.change_dir = function()
    local function enter(prompt_bufnr)
        local selected = state.get_selected_entry()
        local cmd = string.format("%s %s", "cd", selected[1])
        vim.cmd(cmd)
        actions.close(prompt_bufnr)
    end

    local input = { os.getenv("HOME") .. "/.local/bin/tmux-workspace", "list" }

    local opts = {
        finder = finders.new_oneshot_job(input, {}),
        sorter = sorters.get_generic_fuzzy_sorter(),
        attach_mappings = function(prompt_bufnr, map)
            map("i", "<cr>", function()
                enter(prompt_bufnr)
            end)
            return true
        end
    }

    local picker = pickers.new({}, opts)
    picker:find()
end

return M
