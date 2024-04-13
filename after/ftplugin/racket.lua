local ok, scope = pcall(require, "mini.indentscope")
if ok then
    vim.b.miniindentscope_config = {
        symbol = "│"
    }
else
    vim.notify("mini.indentscope not found: " .. scope, vim.log.levels.WARN)
end
