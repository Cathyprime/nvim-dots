local keymap = vim.keymap.set
local wk = require("which-key").register

-- leader
vim.g.mapleader = " "

-- go home
keymap("n", "gh", "<cmd>Alpha<CR>", { silent = true, desc = "Dashboard" })

-- system keyboard
wk({
    K = {
        name = "Keyboard",
        y = { '"+y', "yank to system keyboard" },
        Y = { '"+Y', "yank line to system keyboard" },
        d = { '"+d', "cut to system keyboard" },
        D = { '"+D', "cut line to system keyboard" },
        p = { '"+p', "paste from system keyboard" },
        P = { '"+P', "paste from system keyboard before" },
    },
}, {
    prefix = "<leader>",
    mode = { "n", "v" },
})

-- telescope
keymap("n", "<Leader>fs", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
keymap("n", "<Leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help Tags" })

-- undo tree
keymap("n", "<F5>", "<cmd>UndotreeToggle<CR>", { noremap = true, silent = true })

-- nvterm
keymap({ "n", "t" }, "<A-h>", function()
    require("nvterm.terminal").toggle("horizontal")
end, { noremap = true, silent = true })
keymap({ "n", "t" }, "<A-v>", function()
    require("nvterm.terminal").toggle("vertical")
end, { noremap = true, silent = true })
keymap({ "n", "t" }, "<A-i>", function()
    require("nvterm.terminal").toggle("float")
end, { noremap = true, silent = true })
