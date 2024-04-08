local ok, _ = pcall(require, "mini.indentscope")
if ok then
    vim.b.miniindentscope_config = {
        symbol = "│"
    }
end
