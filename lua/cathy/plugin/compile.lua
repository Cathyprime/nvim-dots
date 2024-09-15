vim.g.dispatch_handlers = {
    "terminal",
    "headless",
    "job",
}

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.api.nvim_del_user_command("Dispatch")
        vim.api.nvim_create_user_command(
            "Dispatch",
            function(opts)
                local count = 0
                local args = opts.args or ""
                local mods = opts.mods or ""
                local bang = opts.bang and 1 or 0

                if bang == 1 then
                    vim.g["dispatch_ready"] = true
                end
                if opts.count < 0 or opts.line1 == opts.line2 then
                    count = opts.count
                end
                if args == "" and vim.b.dispatch ~= "" then
                    args = vim.b.dispatch
                end
                vim.b["dispatch"] = args
                vim.fn["dispatch#compile_command"](bang, args, count, mods)
            end,
            {
                bang = true,
                nargs = "*",
                range = -1,
                complete = "customlist,dispatch#command_complete",
            }
        )
        vim.api.nvim_del_user_command("Start")
        vim.api.nvim_create_user_command(
            "Start",
            function(opts)
                local count = 0
                local args = opts.args or ""
                local mods = opts.mods or ""
                local bang = opts.bang and 1 or 0

                if opts.count < 0 or opts.line1 == opts.line2 then
                    count = opts.count
                end
                if args == "" and vim.b.start ~= "" then
                    args = vim.b.start or ""
                end
                vim.b["start"] = args
                vim.fn["dispatch#start_command"](bang, args, count, mods)
            end,
            {
                bang = true,
                nargs = "*",
                range = -1,
                complete = "customlist,dispatch#command_complete",
            }
        )
        vim.api.nvim_del_user_command("Copen")
        vim.api.nvim_create_user_command(
            "Copen",
            function(opts)
                local bang = opts.bang and 1 or 0
                vim.g["dispatch_ready"] = false
                vim.fn["dispatch#copen"](bang, opts.mods or "")
            end,
            {
                bang = true,
                bar = true,
            }
        )
    end,
})

return {
    {
        "tpope/vim-dispatch",
        config = function()
            vim.keymap.set("n", "Zc", "<cmd>AbortDispatch<cr>", { silent = true  })
            vim.keymap.set("n", "ZC", "<cmd>AbortDispatch<cr>", { silent = true  })
        end,
    },
}
