vim.b.dispatch = "python %"
vim.keymap.set("n", "<localleader>r", "<cmd>Dispatch<cr>", { silent = true })
-- vim.opt_local.listchars:remove([[leadmultispace]])

local ok, _ = pcall(require, "mini.indentscope")
if ok then
    vim.b.miniindentscope_config = {
        symbol = "│"
    }
end
