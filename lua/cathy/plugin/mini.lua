local minis = {

    indentscope = function()
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
    end,

    align = function()
        require("mini.align").setup()
    end,

    operators = function()
        require("mini.operators").setup({
            sort = {
                prefix = "",
                func = nil,
            },
        })
    end,

    comment = function()
        require("mini.comment").setup({
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
                end,
            },
        })
    end,

    trailspace = function()
        require("mini.trailspace").setup()
    end,

    move = function()
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
    end,

    clue = function()
        local module = require("mini.clue")
        module.setup({
            triggers = {
                { mode = "n", keys = "<leader>m" },
                { mode = "n", keys = "<leader>f" },
                { mode = "n", keys = "<leader>d" },
                { mode = "n", keys = "[" },
                { mode = "n", keys = "]" },
                { mode = "i", keys = "<c-x>" },
            },
            clues = {
                module.gen_clues.builtin_completion(),
                { mode = "n", keys = "]d", postkeys = "]" },
                { mode = "n", keys = "]D", postkeys = "]" },
                { mode = "n", keys = "]{", postkeys = "[", desc = "change direction" },
                { mode = "n", keys = "]c", postkeys = "]" },
                { mode = "n", keys = "]C", postkeys = "]" },
                { mode = "n", keys = "[d", postkeys = "[" },
                { mode = "n", keys = "[D", postkeys = "[" },
                { mode = "n", keys = "[c", postkeys = "[" },
                { mode = "n", keys = "[}", postkeys = "]", desc = "change direction" },
                { mode = "n", keys = "[C", postkeys = "[" },
                { mode = "n", keys = "[]", desc = "Goto prev end function" },
                { mode = "n", keys = "[L", desc = "Goto prev end loop" },
            }
        })
    end,

    misc = function()
        require("mini.misc").setup()
    end,

    splitjoin = function()
        require("mini.splitjoin").setup({
            mappings = {
                toggle = "gs",
            }
        })
    end,

    ai = function()
        local module = require("mini.ai")
        module.setup({
            n_lines = 200,
            custom_textobjects = {
                o = module.gen_spec.treesitter({
                    a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                    i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                }, {}),
                f = module.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                c = module.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
            },
            search_method = "cover_or_next"
        })
    end,

    diff = function()
        local module = require("mini.diff")
        module.setup({
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
                priority = 1,
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
            pcall(module.toggle_overlay)
        end)
    end,

    notify = function()
        local module = require("mini.notify")
        module.setup({
            lsp_progress = {
                enable = false
            },
        })
        vim.notify = module.make_notify({
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
                vim.notify = module.make_notify(levels)
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
                module.show_history()
            end,
            {
                desc = "show message history",
                nargs = 0
            }
        )
    end,

    hipatterns = function()
        local module = require("mini.hipatterns")
        module.setup({
            highlighters = {
                hex_color = module.gen_highlighter.hex_color(),
                fixme = { pattern = 'FIXME', group = 'MiniHipatternsFixme' },
                hack  = { pattern = 'HACK',  group = 'MiniHipatternsHack'  },
                todo  = { pattern = 'TODO',  group = 'MiniHipatternsTodo'  },
                note  = { pattern = 'NOTE',  group = 'MiniHipatternsNote'  },
            }
        })
    end,

    git = function()
        require("mini.git").setup()
    end,

    statusline = function()
        require("mini.statusline").setup({
            content = {
                active = function()
                    local config = require("cathy.config.statusline")
                    local ok, ft = config.filetype_specific()
                    if ok then
                        return ft(true)
                    end
                    local mode, mode_hl = config.mode({ trunc_width = 120 })
                    local recording     = config.recording({ trunc_width = 20 })
                    local filename      = config.filename({ trunc_width = 20 })
                    local last_button   = config.last_button({ trunc_width = 20 })
                    local diff          = config.diff({ trunc_width = 75 })
                    local diagnostics   = config.diagnostics({ trunc_width = 75 })
                    local cursor_pos    = config.cursor_pos({ trunc_width = 75 })
                    local window        = config.window({ trunc_width = 75 })
                    local five_hls      = config.mode_highlights()
                    local five_hls_b    = config.mode_highlightsB()
                    local git           = MiniStatusline.section_git({ trunc_width = 50 })
                    local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
                    local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
                    local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

                    return MiniStatusline.combine_groups({
                        { hl = mode_hl,                 strings = { mode, recording } },
                        { hl = five_hls_b,              strings = { git, diff } },
                        { hl = 'MiniStatuslineDevinfoB', strings = { filename } },
                        "%=",
                        { hl = 'MiniStatuslineDevinfoB', strings = { last_button } },
                        { hl = 'MiniStatuslineDevinfoB', strings = { search } },
                        { hl = 'MiniStatuslineDevinfoB', strings = { lsp, diagnostics, } },
                        { hl = five_hls_b,              strings = { fileinfo } },
                        "%P ",
                        { hl = five_hls, strings = { cursor_pos, window } },
                    })
                end,
                inactive = function()
                    local config = require("cathy.config.statusline")
                    local ok, ft = config.filetype_specific()
                    if ok then
                        return ft(false)
                    end
                    local filename   = config.filename({ trunc_width = 20 })
                    local cursor_pos = config.cursor_pos({ trunc_width = 75 })
                    local window     = config.window({ trunc_width = 75 })
                    return MiniStatusline.combine_groups({
                        { hl = 'MiniStatuslineDevinfoB', strings = { filename } },
                        "%=",
                        "%P ",
                        { strings = { cursor_pos, window } },
                    })
                end
            }
        })
    end
}

require("mini.deps").later(function()
    for _, func in pairs(minis) do
        func()
    end
end)
