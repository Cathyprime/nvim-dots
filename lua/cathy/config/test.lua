local ok, test = pcall(require, "neotest")
if ok then
    local function map(lhs, rhs)
        local opts = { silent = true, buffer = true }
        vim.keymap.set("n", "<leader>m" .. lhs, rhs, opts)
    end
    map("r", test.run.run)
    map("f", function()
        test.run.run(vim.fn.expand("%"))
    end)
    map("d", function()
        test.run.run({ strategy = "dap" })
    end)
    map("s", test.run.stop)
    map("o", test.summary.toggle)
else
    vim.notify("neotest not found", vim.log.levels.WARN)
end
