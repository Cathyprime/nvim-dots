---@param options { forward: boolean }
local function trouble_jump(options)
    return function()
        require("demicolon.jump").repeatably_do(function(opts)
            if require("trouble").is_open() then
                if opts.forward then
                    require("trouble").next({ skip_groups = true, jump = true })
                else
                    require("trouble").prev({ skip_groups = true, jump = true })
                end
            end
        end, options)
    end
end

return {
    {
        "Eandrju/cellular-automaton.nvim",
        cmd = "CellularAutomaton"
    },
    {
        "mawkler/demicolon.nvim",
        lazy = true,
        opts = {
            keymaps = {
                horizontal_motions = true,
                diagnostic_motions = false,
                repeat_motions = false,
            },
            integrations = {
                gitsigns = {
                    enabled = false,
                },
            },
        },
        config = function(_, opts)
            require("demicolon").setup(opts)
            local ts_repeatable_move = require('nvim-treesitter.textobjects.repeatable_move')
            local nxo = {"n", "x", "o"}

            vim.keymap.set(nxo, ';', ts_repeatable_move.repeat_last_move)
            vim.keymap.set(nxo, ',', ts_repeatable_move.repeat_last_move_opposite)
        end
    },
    {
        "folke/trouble.nvim",
        config = true,
        dependencies = "mawkler/demicolon.nvim",
        cmd = "Trouble",
        opts = {
            modes = {
                current_project_diagnostics = {
                    auto_close = false,
                    mode = "diagnostics", -- inherit from diagnostics mode
                    filter = {
                        any = {
                            buf = 0, -- current buffer
                            {
                                severity = vim.diagnostic.severity.ERROR, -- errors only
                                -- limit to files in the current project
                                function(item)
                                    return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
                                end,
                            },
                        },
                    },
                }
            }
        },
        keys = {
            { "Zx", "<cmd>Trouble lsp_document_symbols toggle focus=true<cr>", silent = true },
            { "ZX", "<cmd>Trouble current_project_diagnostics toggle<cr>", silent = true },
            { "gR", "<cmd>Trouble lsp_references toggle<cr>", silent = true },
            { "]d", trouble_jump({ forward = true}), desc = "Next trouble item" },
            { "[d", trouble_jump({ forward = false }), desc = "Prev trouble item" },
        }
    },
    {
        "mbbill/undotree",
        config = function()
            vim.g.undotree_WindowLayout = 2
            vim.g.undotree_ShortIndicators = 0
            vim.g.undotree_SplitWidth = 40
            vim.g.undotree_SetFocusWhenToggle = 1
            vim.g.undotree_DiffCommand = [[diff]]
        end,
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>" }
        }
    },
    {
        "Vigemus/iron.nvim",
        config = function()
            require("iron.core").setup({
                config = {
                    repl_open_cmd = "vertical botright 70 split",
                    repl_definition = {
                        sh = {
                            command = { "zsh" },
                        },
                    },
                },
                keymaps = {
                    send_motion = "<localleader>",
                    visual_send = "<localleader>",
                    send_file = "<localleader>f",
                    send_line = "<localleader><localleader>",
                    cr = "<localleader><cr>",
                    interrupt = "<localleader><c-c>",
                    exit = "<localleader><c-d>",
                    clear = "<localleader><c-l>",
                    send_mark = "<localleader>mm",
                    mark_motion = "<localleader>m",
                    mark_visual = "<localleader>m",
                    remove_mark = "<localleader>md",
                },
            })
        end,
        keys = {
            { "<leader>is", "<cmd>IronRepl<cr>" },
            { "<leader>ih", "<cmd>IronHide<cr>" },
            { "<leader>if", "<cmd>IronWatch file<cr>" },
            { "<leader>im", "<cmd>IronWatch mark<cr>" }
        }
    },
    "milisims/nvim-luaref",
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        keys = { { "<leader>w", "<cmd>ZenMode<cr>" } },
        config = function()
            require("zen-mode").setup({
                plugins = {
                    options = {
                        enabled = true,
                        ruler = false,
                        showcmd = false,
                        laststatus = 0,
                    },
                    twilight = { enabled = false },
                    gitsigns = { enabled = true },
                    wezterm = {
                        enabled = true,
                        font = 4,
                    },
                    neovide = {
                        enabled = true,
                        scale = 1.02
                    },
                },
                on_open = function()
                    vim.opt.fillchars = [[foldclose:>,foldopen:v,foldsep: ,fold: ]]
                end
            })
        end
    },
    {
        "chrishrb/gx.nvim",
        cmd = "Browse",
        config = true,
        keys = {
            { "gX", "<cmd>Browse<cr>" }
        },
    },
    {
        "cbochs/grapple.nvim",
        config = function()
            require("grapple").setup({
                scope = "git_branch",
            })
        end,
        cmd = "Grapple",
        keys = function()
            local grapple = require("grapple")
            return {
                { "<leader>a", grapple.toggle },
                { "<leader>e", grapple.toggle_tags },
                { "<leader>1", function() grapple.select({ index = 1 }) end },
                { "<leader>2", function() grapple.select({ index = 2 }) end },
                { "<leader>3", function() grapple.select({ index = 3 }) end },
                { "<leader>4", function() grapple.select({ index = 4 }) end },
                { "<leader>5", function() grapple.select({ index = 5 }) end },
                { "<c-s-a>", function() grapple.cycle_scopes("next") end },
                { "<c-s-x>", function() grapple.cycle_scopes("prev") end },
                { "<c-s-f>", function() grapple.cycle_tags("next") end },
                { "<c-s-s>", function() grapple.cycle_tags("prev") end }
            }
        end
    },
    {
        "NStefan002/screenkey.nvim",
        lazy = false,
        version = "*",
    },
    {
        "Cathyprime/project.nvim",
        config = function()
            require("project_nvim").setup({
                show_hidden = true,
                detection_methods = { "pattern" },
                exclude_dirs = {
                    "~/.cargo/*",
                    "~/.rustup/*",
                    "~/.local/*",
                    "~/go/pkg/*",
                    "~/Polygon/*",
                    "*node_modules/*",
                },
                patterns = {
                    ".git",
                    "_darcs",
                    ".hg",
                    ".bzr",
                    ".svn",
                    "*.csproj",
                    "Makefile",
                    "README.md",
                    "package.json",
                    "build.sbt",
                    "main.c",
                    "main.cc",
                    "main.cpp",
                    "gradlew",
                    "go.mod",
                    "Cargo.toml",
                    "docker-compose.yml",
                },
                file_ignore_patterns = require("cathy.utils.telescope.config").ignores,
            })
        end
    },
}
