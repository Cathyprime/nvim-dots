local add   = require("mini.deps").add
local later = require("mini.deps").later
local now   = require("mini.deps").now

local function keymap(lhs, rhs, config, opts, mode)
    mode = mode or "n"
    opts = opts or {}
    vim.keymap.set(mode, lhs, function()
        config()
        vim.keymap.set(mode, lhs, rhs, opts)
        if type(rhs) == "function" then
            rhs()
        else
            local str = rhs:gsub("%<.-%>", "")
            vim.cmd(str)
        end
    end, opts)
end

add("mbbill/undotree")
later(function()
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_ShortIndicators = 0
    vim.g.undotree_SplitWidth = 40
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_DiffCommand = [[diff]]
    vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>")
end)

add("dohsimpson/vim-macroeditor")

add({
    source = "kevinhwang91/nvim-fundo",
    depends = { "kevinhwang91/promise-async" },
})
require("fundo").install()

add("Vigemus/iron.nvim")
local iron_setup = function()
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
end
keymap("<leader>is", "<cmd>IronRepl<cr>", iron_setup)
keymap("<leader>ih", "<cmd>IronHide<cr>", iron_setup)
keymap("<leader>if", "<cmd>IronWatch file<cr>", iron_setup)
keymap("<leader>im", "<cmd>IronWatch mark<cr>", iron_setup)

add("milisims/nvim-luaref")

add({
    source = "jellydn/hurl.nvim",
    depends = {
        -- "MunifTanjim/nui.nvim", installed by lua rocks
        "nvim-treesitter/nvim-treesitter"
    }
})

later(function()
    require("hurl").setup({
        debug = false,
        show_notification = false,
        mode = "split",
        split_position = "bottom",
        split_size = "30%",
        formatters = {
            json = { "jq" },
            html = {
                "prettier",
                "--parser",
                "html",
            },
        },
    })
    vim.keymap.set("n", "ZH", "<cmd>HurlRunner<cr>")
    vim.keymap.set("n", "Zh", "<cmd>HurlRunnerAt<cr>")
    vim.keymap.set("v", "Zh", ":HurlRunner<cr>")
end)

add({
    source = "folke/zen-mode.nvim",
    depends = {
        "folke/twilight.nvim",
    },
})

later(function()
    require("zen-mode").setup({
        plugins = {
            options = {
                enabled = true,
                ruler = false,
                showcmd = false,
                laststatus = 0,
            },
            twilight = { enabled = true },
            gitsigns = { enabled = true },
            wezterm = {
                enabled = true,
                font = 4,
            },
        },
        on_open = function()
            vim.opt.fillchars = [[foldclose:>,foldopen:v,foldsep: ,fold: ]]
        end
    })
end)

add("chrishrb/gx.nvim")
later(function()
    ---@diagnostic disable-next-line: missing-parameter
    require("gx").setup()
    vim.keymap.set("n", "gl", "<cmd>Browse<cr>")
end)

add("cbochs/grapple.nvim")
later(function()
    local grapple = require("grapple")
    grapple.setup({
        scope = "git_branch",
    })
    vim.keymap.set("n", "<leader>a", grapple.toggle)
    vim.keymap.set("n", "<leader>e", grapple.toggle_tags)

    vim.keymap.set("n", "<c-f>", function() grapple.cycle_tags("next") end)
    vim.keymap.set("n", "<c-s>", function() grapple.cycle_tags("prev") end)

    vim.keymap.set("n", "<c-s-f>", function() grapple.cycle_scopes("next") end)
    vim.keymap.set("n", "<c-s-s>", function() grapple.cycle_scopes("prev") end)
    vim.api.nvim_del_user_command("Grapple")
end)

add({
    source = "mistricky/codesnap.nvim",
    hooks = {
        post_install = function(opts)
            vim.system({ "make" }, {
                cwd = opts.path,
            })
        end
    }
})
later(function()
    require("codesnap").setup({
        has_breadcrumbs = true,
        save_path = os.getenv("HOME") .. "/Pictures/",
        watermark = "Magda :3"
    })
end)

add("justinhj/battery.nvim")
now(function()
    if vim.g.neovide and vim.fn.hostname() ~= "luna" then
        if vim.fn.executable("acpi") ~= 1 then
            vim.notify("executable `acpi` is not installed", vim.log.levels.ERROR)
        else
            require("battery").setup({
                update_rate_seconds = 30,
                show_status_when_no_battery = false,
                show_plugged_icon = true,
                show_unplugged_icon = false,
                show_percent = true,
                vertical_icons = true,
                multiple_battery_selection = 1,
            })
        end
    end
end)

now(function()
    require("flatten").setup()
end)

later(function()
    local hint = [[
 Arrow^^^^^^
 ^ ^ _K_ ^ ^   Select region with <C-v>
 _H_ ^ ^ _L_   _f_: surround it with box
 ^ ^ _J_ ^ ^                      _<Esc>_
]]

    require("hydra")({
        name = "venn",
        mode = "n",
        hint = hint,
        config = {
            color = "pink",
            invoke_on_body = true,
            hint = {
                float_opts = {
                    border = "rounded",
                }
            },
            on_enter = function()
                vim.opt_local.virtualedit = "all"
            end,
            on_exit = function()
                vim.opt_local.virtualedit = ""
            end
        },
        body = "<leader>v",
        heads = {
            { "H", "<C-v>h:VBox<CR>" },
            { "J", "<C-v>j:VBox<CR>" },
            { "K", "<C-v>k:VBox<CR>" },
            { "L", "<C-v>l:VBox<CR>" },
            { "f", ":VBox<CR>", { mode = "v" }},
            { "<Esc>", nil, { exit = true } },
        }
    })
end)

add("Eandrju/cellular-automaton.nvim")

later(function()
    local function map(lhs, rhs)
        vim.keymap.set("n", "<leader>h" .. lhs, rhs)
    end
    local track = require("track")
    map("a", track.toggle)
    map("c", track.clear)
    map("e", track.edit)
    vim.keymap.set("n", "<leader>fa", track.search, { desc = "annotations" })
end)
