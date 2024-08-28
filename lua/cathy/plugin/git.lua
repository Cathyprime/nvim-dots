return {
    {
        "sindrets/diffview.nvim",
        keys = {
            { "<leader>gd", "<cmd>DiffviewOpen<cr>" },
            { "<leader>gc", "<cmd>DiffviewClose<cr>" }
        },
        config = true
    },
    {
        "FabijanZulj/blame.nvim",
        config = true,
    },
    {
        "NeogitOrg/neogit",
        keys = {
            { "ZG",  function()
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
                require("neogit").open({ kind = "tab" })
            end }
        },
        config = true,
        init =  function()
            vim.api.nvim_create_autocmd("Filetype", {
                group = vim.api.nvim_create_augroup("cathy_neogit", { clear = true }),
                pattern = "Neogit*",
                command = "setlocal foldcolumn=0"
            })
        end
    },
}
