local keymap = vim.keymap.set

-- leader
vim.g.mapleader = " "

-- go home
keymap("n", "gh", "<cmd>Alpha<CR>", { silent = true, desc = "Dashboard" })

-- system keyboard
require("which-key").register({
    K = {
        name = "Keyboard",
    },
}, { prefix = "<leader>" })
keymap("n", "<leader>Ky", '"+y', { silent = true, desc = "copy to system keyboard" })
keymap("n", "<leader>Ky", '"+Y', { silent = true, desc = "copy line to system keyboard" })
keymap("n", "<leader>Kd", '"+d', { silent = true, desc = "cut to system keyboard" })
keymap("n", "<leader>KD", '"+D', { silent = true, desc = "cut line to system keyboard" })
keymap("n", "<leader>Kp", '"+p', { silent = true, desc = "paste from system keyboard" })
keymap("n", "<leader>KP", '"+P', { silent = true, desc = "paste from system keyboard before" })

-- telescope
keymap("n", "<Leader>fs", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
keymap("n", "<Leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help Tags" })

-- undo tree
keymap("n", "<F5>", "<cmd>UndotreeToggle<CR>", { noremap = true, silent = true })

-- Switch lines VS**** style
keymap("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
keymap("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- nvterm
keymap("n", "<A-h>", function()
    require("nvterm.terminal").toggle("horizontal")
end, { noremap = true, silent = true })
keymap("n", "<A-v>", function()
    require("nvterm.terminal").toggle("vertical")
end, { noremap = true, silent = true })
keymap("n", "<A-i>", function()
    require("nvterm.terminal").toggle("float")
end, { noremap = true, silent = true })
keymap("t", "<A-h>", function()
    require("nvterm.terminal").toggle("horizontal")
end, { noremap = true, silent = true })
keymap("t", "<A-v>", function()
    require("nvterm.terminal").toggle("vertical")
end, { noremap = true, silent = true })
keymap("t", "<A-i>", function()
    require("nvterm.terminal").toggle("float")
end, { noremap = true, silent = true })
