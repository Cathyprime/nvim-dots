require("mini.deps").add("nvim-neotest/neotest-go")

vim.cmd.packadd("neotest")
local ok, test = pcall(require, "neotest")
if ok then
    test.setup({
        adapters = {
            require("rustaceanvim.neotest"),
            require("neotest-go")
        }
    })
    require("cathy.config.test")
else
    vim.notify("neotest not found", vim.log.levels.WARN)
end
