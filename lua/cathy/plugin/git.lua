local md = require("mini.deps")

md.add("sindrets/diffview.nvim")
md.add("FabijanZulj/blame.nvim")
md.add({
    source = "NeogitOrg/neogit",
    checkout = "nightly"
})

md.later(function()
    require("diffview").setup()

    vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>")
    vim.keymap.set("n", "<leader>gc", "<cmd>DiffviewClose<cr>")
end)

md.now(function()
    local neogit = require("neogit")
    neogit.setup({})
    vim.keymap.set("n", "ZG", function() neogit.open({ kind = "tab" }) end)
end)

md.later(function()
    vim.keymap.set("n", "<leader>gb", "<cmd>ToggleBlame<cr>")
    vim.keymap.set("n", "<leader>gB", "<cmd>ToggleBlame virtual<cr>")
end)
