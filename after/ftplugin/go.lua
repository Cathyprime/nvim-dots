vim.opt_local.expandtab = false
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.api.nvim_create_autocmd("BufEnter", {
    once = true,
    callback = function()
        vim.opt.indentkeys:remove("<:>")
        vim.opt_local.formatoptions:append("ro")
    end
})

local function map(lhs, rhs, opts, mode)
    opts = vim.tbl_deep_extend("force", { buffer = true, silent = false }, opts or {})
    vim.keymap.set(mode or "n", "<localleader>" .. lhs, rhs, opts)
end
map("e", "<cmd>GoIfErr<cr>")
