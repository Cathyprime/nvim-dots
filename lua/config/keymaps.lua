local keymap = vim.keymap

-- leader
vim.g.mapleader = " "

-- go home
keymap.set("n", "gh", "<cmd>Alpha<CR>", { silent = true, desc = "Dashboard" })

-- C-c to Esc
keymap.set("i", "<C-c>", "<Esc>", { noremap = false })
keymap.set("v", "<C-c>", "<Esc>", { noremap = false })

-- telescope
keymap.set("n", "<Leader>fs", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
keymap.set("n", "<Leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help Tags" })

-- undo tree
keymap.set("n", "<F5>", "<cmd>UndotreeToggle<CR>", { noremap = true, silent = true })

-- Switch lines VS**** style
keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- nvterm
keymap.set("n", "<A-h>", function()
    require("nvterm.terminal").toggle("horizontal")
end, { noremap = true, silent = true })
keymap.set("n", "<A-v>", function()
    require("nvterm.terminal").toggle("vertical")
end, { noremap = true, silent = true })
keymap.set("n", "<A-i>", function()
    require("nvterm.terminal").toggle("float")
end, { noremap = true, silent = true })
keymap.set("t", "<A-h>", function()
    require("nvterm.terminal").toggle("horizontal")
end, { noremap = true, silent = true })
keymap.set("t", "<A-v>", function()
    require("nvterm.terminal").toggle("vertical")
end, { noremap = true, silent = true })
keymap.set("t", "<A-i>", function()
    require("nvterm.terminal").toggle("float")
end, { noremap = true, silent = true })
