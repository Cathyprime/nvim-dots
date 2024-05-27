local add = require("mini.deps").add
local later = require("mini.deps").later

add("kylechui/nvim-surround")

later(function()
    vim.api.nvim_create_autocmd("InsertEnter", {
        once = true,
        callback = function()
            ---@diagnostic disable-next-line
            require("nvim-surround").setup({
                keymaps = {
                    insert = "<c-d>",
                    insert_line = "<c-s>",
                    normal = "s",
                    normal_cur = "ss",
                    normal_line = "S",
                    normal_cur_line = "SS",
                    visual = "s",
                    visual_line = "S",
                    delete = "ds",
                    change = "cs",
                    change_line = "cS",
                },
            })
        end,
    })
end)

add("monaqa/dial.nvim")
later(function()
    vim.api.nvim_create_autocmd({ "InsertEnter", "BufReadPost", "BufWritePost", "BufNewFile" }, {
        once = true,
        callback = function()
            local augend = require("dial.augend")
            local function extend(t)
                local defaults = {
                    augend.integer.alias.binary,
                    augend.integer.alias.decimal_int,
                    augend.integer.alias.hex,
                    augend.integer.new {
                        radix = 16,
                        prefix = "#",
                        natural = true,
                        case = "upper"
                    },
                    augend.date.alias["%d/%m/%Y"],
                    augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
                    augend.constant.new({ elements = { "and", "or" } }),
                    augend.constant.new({
                        elements = { "true", "false" },
                        word = true,
                        cyclic = true,
                        preserve_case = true,
                    }),
                    augend.decimal_fraction.new({
                        signed = true,
                        point_char = ".",
                    }),
                    augend.constant.alias.Alpha,
                }
                for _, v in ipairs(t or {}) do
                    table.insert(defaults, v)
                end
                return defaults
            end

            require("dial.config").augends:register_group({
                default = extend(),
                case = {
                    augend.case.new({
                        types = {
                            "camelCase",
                            "PascalCase",
                            "kebab-case",
                            "snake_case",
                            "SCREAMING_SNAKE_CASE",
                        },
                        cyclic = true,
                    }),
                },
            })

            require("dial.config").augends:on_filetype({
                rust = extend({
                    augend.constant.new({
                        elements = {
                            "self",
                            "super",
                            "crate",
                        },
                        cyclic = false,
                    }),
                }),
                cs = extend({
                    augend.constant.new({
                        elements = {
                            "sealed",
                            "private",
                            "protected",
                            "internal",
                            "public",
                        },
                        word = true,
                        cyclic = true,
                    }),
                    augend.constant.new({
                        elements = {
                            "abstract",
                            "virtual",
                        },
                        cyclic = true,
                    }),
                }),
                java = extend({
                    augend.constant.new({
                        elements = {
                            "default",
                            "private",
                            "protected",
                            "public",
                        },
                        word = true,
                        cyclic = true,
                    }),
                }),
            })

            local mani = require("dial.map").manipulate
            vim.keymap.set("n", "<C-a>",  function() mani("increment", "normal") end)
            vim.keymap.set("n", "<C-x>",  function() mani("decrement", "normal") end)
            vim.keymap.set("n", "g<C-a>", function() mani("increment", "gnormal") end)
            vim.keymap.set("n", "g<C-x>", function() mani("decrement", "gnormal") end)
            vim.keymap.set("v", "<C-a>",  function() mani("increment", "visual") end)
            vim.keymap.set("v", "<C-x>",  function() mani("decrement", "visual") end)
            vim.keymap.set("v", "g<C-a>", function() mani("increment", "gvisual") end)
            vim.keymap.set("v", "g<C-x>", function() mani("decrement", "gvisual") end)
            vim.keymap.set("n", "<c-g>",  function() mani("increment", "normal", "case") end)
        end,
    })
end)

add("zbirenbaum/copilot.lua")
later(function()
    vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
        once = true,
        callback = function()
            require("copilot").setup({
                panel = { enabled = false },
                suggestion = {
                    enabled = true,
                    auto_trigger = false,
                    keymap = {
                        accept = "<m-y>",
                        accept_word = "<m-w>",
                        accept_line = "<m-l>",
                        next = "<m-n>",
                        prev = "<m-p>",
                        dismiss = "<m-e>",
                    },
                },
            })
        end,
    })
end)

add("tpope/vim-abolish")
