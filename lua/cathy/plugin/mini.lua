local later = require("mini.deps").later

-- now(function()
--     local config = require("cathy.config.ministarter")
--     require("mini.starter").setup(config)
-- end)

later(function()

    require("mini.indentscope").setup({
        symbol = "",
    })
    vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("cathy_indent_scope", { clear = true }),
        callback = function()
            if vim.opt.shiftwidth:get() == 2 and vim.opt.tabstop:get() == 2 then
                vim.b.miniindentscope_config = {
                    symbol = "│"
                }
            end
        end
    })

    require("mini.align").setup()

    require("mini.operators").setup({
        sort = {
            prefix = "",
            func = nil,
        },
        multiply = {
            prefix = "",
            func = nil,
        }
    })

    require("mini.comment").setup({
        options = {
            custom_commentstring = function()
                return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
            end,
        },
    })

    require("mini.trailspace").setup()

    require("mini.move").setup({
        mappings = {
            left       = "<m-h>",
            right      = "<m-l>",
            down       = "<m-j>",
            up         = "<m-k>",
            line_left  = "",
            line_right = "",
            line_down  = "<m-j>",
            line_up    = "<m-k>",
        }
    })

    local clue = require("mini.clue")
    clue.setup({
        triggers = {
            { mode = "n", keys = "<leader>m" },
            { mode = "n", keys = "<leader>f" },
            { mode = "n", keys = "<leader>d" },
            { mode = "n", keys = "[" },
            { mode = "n", keys = "]" },
            { mode = "i", keys = "<c-x>" },
        },
        clues = {
            clue.gen_clues.builtin_completion(),
            { mode = "n", keys = "]d", postkeys = "]" },
            { mode = "n", keys = "]c", postkeys = "]" },
            { mode = "n", keys = "[d", postkeys = "[" },
            { mode = "n", keys = "[c", postkeys = "[" },
        }
    })

    require("mini.misc").setup()

    require("mini.splitjoin").setup({
        mappings = {
            toggle = "gs",
        }
    })

    local ai = require("mini.ai")
    ai.setup({
        n_lines = 200,
        custom_textobjects = {
            o = ai.gen_spec.treesitter({
                a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                i = { "@block.inner", "@conditional.inner", "@loop.inner" },
            }, {}),
            f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
            c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
        search_method = "cover_or_next"
    })

    require("mini.diff").setup({
        mappings = {
            apply = "",
            reset = "",
        },
        view = {
            style = "sign",
            signs = {
                add    = "┃",
                change = "┃",
                delete = "▁",
            },
        },
    })
    local set = function()
        vim.api.nvim_set_hl(0, "MiniDiffSignAdd", {
            link = "diffAdded",
        })
        vim.api.nvim_set_hl(0, "MiniDiffSignChange", {
            link = "diffChanged",
        })
        vim.api.nvim_set_hl(0, "MiniDiffSignDelete", {
            link = "diffDeleted",
        })
    end
    set()
    vim.api.nvim_create_autocmd("Colorscheme", {
        callback = set
    })
    vim.keymap.set("n", "<leader>go", function()
        pcall(MiniDiff.toggle_overlay)
    end)

    require("mini.notify").setup({
        lsp_progress = {
            enable = false
        },
    })
    vim.notify = require("mini.notify").make_notify({
        ERROR = { duration = 5000 },
        WARN  = { duration = 4000 },
        INFO  = { duration = 3000 },
    })
    vim.api.nvim_create_user_command(
        "Notify",
        function(opts)
            local trans = {
                ["off"]   = 5,
                ["error"] = 4,
                ["warn"]  = 3,
                ["info"]  = 2,
                ["debug"] = 1,
                ["trace"] = 0
            }
            local level = trans[opts.fargs[1]:lower()]
            local levels = vim.iter({
                ERROR = { duration = 5000 },
                WARN  = { duration = 4000 },
                INFO  = { duration = 3000 },
                DEBUG = { duration = 6000 },
                TRACE = { duration = 1000 },
            })
                :fold({}, function(acc, key, value)
                if vim.log.levels[key] < level then
                    value["duration"] = 0
                end
                acc[key] = value
                return acc
            end)
            vim.notify = require("mini.notify").make_notify(levels)
        end,
        {
            nargs = 1,
            complete = function(arg_lead)
                return vim.iter({
                    "off",
                    "error",
                    "warn",
                    "info",
                    "debug",
                    "trace"
                })
                    :filter(function(value)
                        return value:sub(1, #arg_lead) == arg_lead:lower()
                    end)
                    :totable()
            end
        }
    )
    vim.api.nvim_create_user_command(
        "MessHistory",
        function()
            MiniNotify.show_history()
        end,
        {
            desc = "show message history",
            nargs = 0
        }
    )

   require("mini.hipatterns").setup({
       highlighters = {
           hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
           fixme = { pattern = 'FIXME',       group = 'MiniHipatternsFixme' },
           hack  = { pattern = 'HACK',        group = 'MiniHipatternsHack'  },
           todo  = { pattern = 'TODO',        group = 'MiniHipatternsTodo'  },
           note  = { pattern = 'NOTE',        group = 'MiniHipatternsNote'  },
       }
   })

    require("mini.git").setup()

end)
