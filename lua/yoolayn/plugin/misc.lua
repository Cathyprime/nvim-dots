local add   = require("mini.deps").add
local later = require("mini.deps").later

add("mbbill/undotree")
vim.g.undotree_WindowLayout = 2
vim.g.undotree_ShortIndicators = 0
vim.g.undotree_SplitWidth = 40
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_DiffCommand = [[diff]]
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>")

add("kevinhwang91/nvim-bqf")
---@diagnostic disable-next-line
require("bqf").setup({
    func_map = {
        open = "<CR>",
        openc = "o",
        drop = "",
        tabdrop = "",
        tab = "",
        tabb = "",
        tabc = "",
        split = "",
        vsplit = "",
        prevfile = "",
        nextfile = "",
        prevhist = "<",
        nexthist = ">",
        lastleave = "",
        stoggleup = "",
        stoggledown = "<Tab>",
        stogglevm = "<Tab>",
        stogglebuf = "",
        sclear = "z<Tab>",
        pscrollup = "",
        pscrolldown = "",
        pscrollorig = "",
        ptogglemode = "P",
        ptoggleitem = "",
        ptoggleauto = "p",
        filter = "zn",
        filterr = "zN",
        fzffilter = "",
    },
    ---@diagnostic disable-next-line
    preview = {
        auto_preview = false,
    },
})

add("dohsimpson/vim-macroeditor")

add({
    source = "kevinhwang91/nvim-fundo",
    depends = {"kevinhwang91/promise-async"},
})
require("fundo").install()

add("Vigemus/iron.nvim")
later(function()
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
    vim.keymap.set("n", "<leader>is", "<cmd>IronRepl<cr>")
    vim.keymap.set("n", "<leader>ih", "<cmd>IronHide<cr>")
    vim.keymap.set("n", "<leader>if", "<cmd>IronWatch file<cr>")
    vim.keymap.set("n", "<leader>im", "<cmd>IronWatch mark<cr>")
end)

add("milisims/nvim-luaref")
add({
    source = "KaitlynEthylia/Evalua",
    depends = {"nvim-treesitter/nvim-treesitter"},
})

later(function()
    require("evalua")
    vim.keymap.set("n", "ZE", "<cmd>Evalua<cr>")
end)

add({
    source = "jellydn/hurl.nvim",
    depends = {"MunifTanjim/nui.nvim"},
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
    vim.keymap.set("n", "<c-c>H", "<cmd>HurlRunner<cr>")
    vim.keymap.set("n", "<c-c>h", "<cmd>HurlRunnerAt<cr>")
    vim.keymap.set("n", "<leader>th", "<cmd>HurlToggleMode<cr>")
    vim.keymap.set("v", "<c-c>h", ":HurlRunner<cr>")
end)
