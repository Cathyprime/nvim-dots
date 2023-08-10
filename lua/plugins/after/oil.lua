local oil = require("oil")

vim.keymap.set("n", "<leader>ee", function() oil.open() end, {desc = "explore edit"})
