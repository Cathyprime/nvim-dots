require("mini.deps").add("tpope/vim-dispatch")
require("mini.deps").add("tpope/vim-fugitive")

require("mini.deps").later(function()
    vim.keymap.set("n", "<leader>gg", "<cmd>G<cr>")
end)
