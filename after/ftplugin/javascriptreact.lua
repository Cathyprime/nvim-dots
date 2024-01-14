vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
-- vim.opt_local.listchars:remove "tab"
-- vim.opt_local.listchars:append [[tab:\u00b7\u0020\u0020]]
-- vim.opt_local.listchars:append [[leadmultispace:\u0020\u0020\u0020]]
local ok, _ = pcall(require, "mini.indentscope")
if ok then
    vim.b.miniindentscope_config = {
        symbol = "│"
    }
end
