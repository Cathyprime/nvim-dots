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
now(function()
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
    --     "MunifTanjim/nui.nvim", installed by lua rocks
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
    vim.keymap.set("n", "<leader>th", "<cmd>HurlToggleMode<cr>")
    vim.keymap.set("v", "Zh", ":HurlRunner<cr>")
end)

add("folke/todo-comments.nvim")
later(function()
    require("todo-comments").setup()
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
    })
end)

add("chrishrb/gx.nvim")
later(function()
    ---@diagnostic disable-next-line: missing-parameter
    require("gx").setup()
    vim.keymap.set("n", "gl", "<cmd>Browse<cr>")
end)

now(function()
    vim.keymap.set("n", "<leader>a", require("grapple").toggle)
    vim.keymap.set("n", "<leader>e", require("grapple").toggle_tags)
    vim.keymap.set("n", "<c-g>", "<cmd>Grapple select index=1<cr>")
    vim.keymap.set("n", "<c-h>", "<cmd>Grapple select index=2<cr>")
    vim.keymap.set("n", "<c-n>", "<cmd>Grapple select index=3<cr>")
    vim.keymap.set("n", "<c-j>", "<cmd>Grapple select index=4<cr>")

    vim.keymap.set("n", "<c-f>", "<cmd>Grapple cycle_tags next<cr>")
    vim.keymap.set("n", "<c-s>", "<cmd>Grapple cycle_tags prev<cr>")
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

require("mini.deps").now(function()
    require("flatten").setup()
end)
