local minis = {

    indentscope = function()
        require("mini.indentscope").setup({
            symbol = "",
        })
        vim.api.nvim_create_autocmd("BufEnter", {
            group = vim.api.nvim_create_augroup("cathy_indent_scope", { clear = true }),
            callback = function()
                if vim.opt.shiftwidth:get() <= 2 or vim.opt.tabstop:get() <= 2 then
                    vim.b.miniindentscope_config = {
                        symbol = "│"
                    }
                end
            end
        })
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
                { mode = "n", keys = "<leader>f" },
                { mode = "i", keys = "<c-x>" },
            },
            clues = {
                module.gen_clues.builtin_completion(),
            }
        })
    end,

    misc = function()
        require("mini.misc").setup()
    end,

    splitjoin = function()
        require("mini.splitjoin").setup({
            mappings = {
                toggle = "<leader>s",
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
                t = module.gen_spec.treesitter({ a = "@type.outer", i = "@type.inner" }, {})
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
        vim.keymap.set("n", "<leader>go", function()
            pcall(module.toggle_overlay)
        end)
    end,

    -- notify = function()
    --     local module = require("mini.notify")
    --     module.setup({
    --         lsp_progress = {
    --             enable = false
    --         },
    --     })
    --     vim.notify = module.make_notify({
    --         ERROR = { duration = 5000 },
    --         WARN  = { duration = 4000 },
    --         INFO  = { duration = 3000 },
    --     })
    --     vim.api.nvim_create_user_command(
    --         "Notify",
    --         function(opts)
    --             local trans = {
    --                 ["off"]   = 5,
    --                 ["error"] = 4,
    --                 ["warn"]  = 3,
    --                 ["info"]  = 2,
    --                 ["debug"] = 1,
    --                 ["trace"] = 0
    --             }
    --             local level = trans[opts.fargs[1]:lower()]
    --             local levels = vim.iter({
    --                 ERROR = { duration = 5000 },
    --                 WARN  = { duration = 4000 },
    --                 INFO  = { duration = 3000 },
    --                 DEBUG = { duration = 6000 },
    --                 TRACE = { duration = 1000 },
    --             })
    --                 :fold({}, function(acc, key, value)
    --                 if vim.log.levels[key] < level then
    --                     value["duration"] = 0
    --                 end
    --                 acc[key] = value
    --                 return acc
    --             end)
    --             vim.notify = module.make_notify(levels)
    --         end,
    --         {
    --             nargs = 1,
    --             complete = function(arg_lead)
    --                 return vim.iter({
    --                     "off",
    --                     "error",
    --                     "warn",
    --                     "info",
    --                     "debug",
    --                     "trace"
    --                 })
    --                     :filter(function(value)
    --                         return value:sub(1, #arg_lead) == arg_lead:lower()
    --                     end)
    --                     :totable()
    --             end
    --         }
    --     )
    --     vim.api.nvim_create_user_command(
    --         "NotifyHistory",
    --         function()
    --             module.show_history()
    --         end,
    --         {
    --             desc = "show message history",
    --             nargs = 0
    --         }
    --     )
    -- end,

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
        local align_blame = function(au_data)
            if au_data.data.git_subcommand ~= 'blame' then return end

            -- Align blame output with source
            local win_src = au_data.data.win_source
            vim.wo.wrap = false
            vim.fn.winrestview({ topline = vim.fn.line('w0', win_src) })
            vim.api.nvim_win_set_cursor(0, { vim.fn.line('.', win_src), 0 })
            vim.api.nvim_win_set_width(0, 56)

            -- Bind both windows so that they scroll together
            vim.wo[win_src].scrollbind, vim.wo.scrollbind = true, true
        end

        local au_opts = { pattern = 'MiniGitCommandSplit', callback = align_blame }
        vim.api.nvim_create_autocmd('User', au_opts)
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
                    -- local recording     = config.recording({ trunc_width = 20 })
                    local filename      = config.filename({ trunc_width = 110 })
                    local last_button   = config.last_button({ trunc_width = 20 })
                    local diff          = config.diff({ trunc_width = 75 })
                    local diagnostics   = config.diagnostics({ trunc_width = 75 })
                    local cursor_pos    = config.cursor_pos_min({ trunc_width = 75 })
                    local five_hls      = config.mode_highlights()
                    local five_hls_b    = config.mode_highlightsB()
                    local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
                    local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

                    return MiniStatusline.combine_groups({
                        { hl = mode_hl,                 strings = { mode --[[, recording ]] } },
                        { hl = 'MiniStatuslineDevinfoB', strings = { filename } },
                        "%=",
                        { hl = 'MiniStatuslineDevinfoB', strings = { last_button, search, diff } },
                        { hl = five_hls_b, strings = { lsp, diagnostics, } },
                        { hl = five_hls, strings = { cursor_pos } },
                        "%P ",
                    })
                end,
                inactive = function()
                    local config = require("cathy.config.statusline")
                    local ok, ft = config.filetype_specific()
                    if ok then
                        return ft(false)
                    end
                    local filename   = config.filename({ trunc_width = 110 })
                    local cursor_pos = config.cursor_pos_min({ trunc_width = 75 })
                    return MiniStatusline.combine_groups({
                        { hl = 'MiniStatuslineDevinfoB', strings = { filename } },
                        "%=",
                        { strings = { cursor_pos } },
                        "%P ",
                    })
                end
            }
        })
    end,

    sessions = function()
        require("mini.sessions").setup({
            autoread = false,
            autowrite = true,
            file = "~/.local/share/nvim/sessions",
            force = {
                delete = true
            }
        })
        vim.api.nvim_create_user_command(
            "Mksession",
            function()
                require("mini.sessions").write("default")
            end,
            {}
        )
        vim.api.nvim_create_user_command(
            "Delsession",
            function()
                require("mini.sessions").delete("default")
            end,
            {}
        )
        vim.api.nvim_create_autocmd("VimEnter", {
            once = true,
            nested = true,
            callback = function()
                if MiniSessions.detected["default"] ~= nil then
                    require("mini.sessions").read("default")
                    vim.cmd.enew()
                    vim.api.nvim_set_option_value("buftype", "nofile", { buf = 0 })
                    vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = 0 })
                    vim.api.nvim_set_option_value("swapfile", false, { buf = 0 })
                    vim.api.nvim_buf_set_lines(0, 0, -1, false, {
                        "This buffer is for text that is not saved",
                        "To open a file, press <space>ff",
                        "",
                        "                    ▞▀▖",
                        " ▛▚▀▖▙▀▖▙▀▖▙▀▖▛▀▖ ▐▌ ▄▘",
                        " ▌▐ ▌▌  ▌  ▌  ▙▄▘ ▗▖▖ ▌",
                        " ▘▝ ▘▘  ▘  ▘  ▌   ▝▘▝▀ ",
                    })
                end
            end,
        })
    end,

    surround = function()
        local ts_input = require("mini.surround").gen_spec.input.treesitter
        require("mini.surround").setup({
            custom_surroundings = {
                t = {
                    input = ts_input({ outer = "@type.outer", inner = "@type.inner" }),
                    output = function()
                        local type_name = MiniSurround.user_input("Type name")
                        return { left = type_name.."<", right = ">" }
                    end
                },
                T = {
                    input = { '<(%w-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },
                    output = function()
                        local tag_full = MiniSurround.user_input('Tag')
                        if tag_full == nil then return nil end
                        local tag_name = tag_full:match('^%S*')
                        return { left = '<' .. tag_full .. '>', right = '</' .. tag_name .. '>' }
                    end,
                },
            },
            mappings = {
                add = "s",
                delete = "ds",
                find = "",
                find_left = "",
                highlight = "",
                replace = "cs",
                update_n_lines = "",
            },
            search_method = 'cover_or_next',
        })
        vim.keymap.set("n", "ss", "s_", { remap = true })
        vim.keymap.set("n", "S", "s", { remap = false })
    end,

    icons = function()
        require("mini.icons").setup()
        MiniIcons.mock_nvim_web_devicons()
    end

}

return {
    "echasnovski/mini.nvim",
    config = function()
        vim.iter(minis):each(function(_, fn) fn() end)
    end
}
