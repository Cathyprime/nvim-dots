local keymap = vim.keymap

-- leader
vim.g.mapleader = " "

-- C-c to Esc
keymap.set("i", "<C-c>", "<Esc>", { noremap = false })
keymap.set("v", "<C-c>", "<Esc>", { noremap = false })

-- telescope
keymap.set("n", "<Leader>ff", "<cmd>Telescope find_files<CR>")
keymap.set("n", "<Leader>fs", "<cmd>Telescope live_grep<CR>")
keymap.set("n", "<Leader>fh", "<cmd>Telescope help_tags<CR>")

-- undo tree
keymap.set("n", "<F5>", "<cmd>UndotreeToggle<CR>", { noremap = true, silent = true })

-- scroll
keymap.set("n", "<C-d>", "<C-d>", { noremap = true })
keymap.set("n", "<C-u>", "<C-u>", { noremap = true })

-- Switch lines VS**** style
keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

keymap.set("n", "<A-h>", function()
    require("nvterm.terminal").toggle("horizontal")
end, { noremap = true, silent = true })
keymap.set("n", "<A-v>", function()
    require("nvterm.terminal").toggle("vertical")
end, { noremap = true, silent = true })
keymap.set("n", "<A-i>", function()
    require("nvterm.terminal").toggle("float")
end, { noremap = true, silent = true })
