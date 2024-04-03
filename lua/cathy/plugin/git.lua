local md = require("mini.deps")

md.add("sindrets/diffview.nvim")

md.later(function()
    require("diffview").setup()

    vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>")
    vim.keymap.set("n", "<leader>gc", "<cmd>DiffviewClose<cr>")
end)

md.later(function()
    local neogit = require("neogit")
    neogit.setup({
        commit_editor = {
            kind = "split",
        },
        commit_select_view = {
            kind = "tab",
        },
    })
    vim.keymap.set("n", "ZG", function() neogit.open({ kind = "tab" }) end)
end)
