local md = require("mini.deps")

md.add("sindrets/diffview.nvim")
md.add("FabijanZulj/blame.nvim")
md.add("NeogitOrg/neogit")

md.later(function()
    require("diffview").setup()

    vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>")
    vim.keymap.set("n", "<leader>gc", "<cmd>DiffviewClose<cr>")
end)

md.now(function()
    local neogit = require("neogit")
    neogit.setup({})
    vim.keymap.set("n", "ZG", function()
        vim.api.nvim_create_autocmd("TabClosed", {
            once = true,
            callback = function()
                MiniNotify.clear()
                vim.iter(vim.api.nvim_list_bufs()):filter(function(buf)
                    return vim.fn.bufname(buf) == ""
                end):each(function(buf)
                    vim.api.nvim_buf_delete(buf, {})
                end)
            end,
        })
        neogit.open({ kind = "tab" })
    end)

    vim.api.nvim_create_autocmd("Filetype", {
        group = vim.api.nvim_create_augroup("cathy_neogit", { clear = true }),
        pattern = "Neogit*",
        command = "setlocal foldcolumn=0"
    })
end)

md.later(function()
    require("blame").setup()
    vim.keymap.set("n", "<leader>gb", "<cmd>BlameToggle<cr>")
    vim.keymap.set("n", "<leader>gB", "<cmd>BlameToggle virtual<cr>")
end)
