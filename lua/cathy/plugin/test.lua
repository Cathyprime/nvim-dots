local ok, test = pcall(require, "neotest")
if ok then
    test.setup({
        adapters = {
            require("rustaceanvim.neotest")
        }
    })
else
    vim.notify("neotest not found", vim.log.levels.WARN)
end
