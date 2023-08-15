local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local tmux = require("harpoon.tmux")
local term = 1

local function send(command)
    tmux.sendCommand(term, command)
    tmux.gotoTerminal(term)
end

-- harpoon usage
vim.keymap.set("n" , "<leader>h", function() ui.toggle_quick_menu() end, {desc = "harpoon", })
vim.keymap.set("n" , "<leader>a", function() mark.add_file() end, {desc = "add file", })

-- file navigation
vim.keymap.set("n" , "<C-f>", function() ui.nav_file(1) end, {desc = "go to first", })
vim.keymap.set("n" , "<C-s>", function() ui.nav_file(2) end, {desc = "go to second", })
vim.keymap.set("n" , "<c-n>", function() ui.nav_file(3) end, {desc = "go to next", })
vim.keymap.set("n" , "<c-h>", function() ui.nav_file(4) end, {desc = "go to harpoon", })

-- tmux integration
vim.keymap.set("n", "<c-j>", function () tmux.gotoTerminal(term) end, {desc = "go to term"})
vim.keymap.set("n", "<c-k>", function () tmux.gotoTerminal(2) end, {desc = "go to second term"})
vim.keymap.set("n" ,"<leader>tc", function()
    local command = vim.fn.input({ prompt = "bash: " })
    send(command)
end, {desc = "tmux custom", })
vim.keymap.set("n", "<leader>ty", function () send("yarn") end, {desc = "tmux yarn"})
vim.keymap.set("n", "<leader>tr", function () send("cargo") end, {desc = "tmux rust"})
