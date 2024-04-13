require("mini.deps").add("nvim-neotest/neotest-go")

local ok, test = pcall(require, "neotest")
if ok then
    test.setup({
        adapters = {
            require("rustaceanvim.neotest"),
            require("neotest-go")
        }
    })
else
    vim.notify("neotest not found", vim.log.levels.WARN)
end
