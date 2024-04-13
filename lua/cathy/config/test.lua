local ok, test = pcall(require, "neotest")
if ok then
    local function map(lhs, rhs, desc)
        local opts = { silent = true, desc = desc }
        vim.keymap.set("n", "<leader>m" .. lhs, rhs, opts)
    end
    map("r", test.run.run, "run nearest test")
    map("f", function()
        test.run.run(vim.fn.expand("%"))
    end, "test current file")
    map("d", function()
        test.run.run({ strategy = "dap" })
    end, "debug nearest test")
    map("s", test.run.stop, "stop running tests")
    map("o", test.summary.toggle, "open ui")
else
    vim.notify("neotest not found", vim.log.levels.WARN)
end
