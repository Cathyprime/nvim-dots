return {
    -- {
    --     "tpope/vim-fugitive",
    --     dependencies = "tpope/vim-rhubarb",
    --     config = function()
    --         vim.keymap.set("n", "ZG", "<cmd>topleft Git<cr>")
    --         vim.api.nvim_create_autocmd("Filetype", {
    --             pattern = "fugitive",
    --             callback = function()
    --                 vim.keymap.set("n", "<tab>", "=", { buffer = true, remap = true })
    --             end,
    --         })
    --     end,
    -- },
    --
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
        keys = {
            { "<leader>gb", "<cmd>BlameToggle<cr>" },
            { "<leader>gB", "<cmd>BlameToggle virtual<cr>" },
        }
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
