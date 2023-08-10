local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n" , "<leader>h", function() require("harpoon.ui").toggle_quick_menu() end, {desc = "harpoon menu", })
vim.keymap.set("n" , "<leader>a", function() require("harpoon.mark").add_file() end, {desc = "add file", })
vim.keymap.set("n" , "<C-f>", function() require("harpoon.ui").nav_file(1) end, {desc = "go to first", })
vim.keymap.set("n" , "<C-s>", function() require("harpoon.ui").nav_file(2) end, {desc = "go to second", })
vim.keymap.set("n" , "<c-n>", function() require("harpoon.ui").nav_file(3) end, {desc = "go to third", })
vim.keymap.set("n" , "<c-h>", function() require("harpoon.ui").nav_file(4) end, {desc = "go to harpoon!!", })
