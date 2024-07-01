return {
    keep = function()
        if vim.o.filetype == "qf" then
            vim.cmd(".Keep")
        end
    end,
    reject = function()
        if vim.o.filetype == "qf" then
            vim.cmd(".Reject")
        end
    end,
    g_keep = function()
        if vim.o.filetype == "qf" then
            vim.cmd("Keep")
        end
    end,
    g_reject = function()
        if vim.o.filetype == "qf" then
            vim.cmd("Reject")
        end
    end,
}
