vim.opt_local.expandtab = false
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
local ok, _ = pcall(require, "mini.indentscope")
if ok then
    vim.b.miniindentscope_config = {
        symbol = "│"
    }
end
