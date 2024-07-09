return {
    "tpope/vim-fugitive",
    dependencies = "tpope/vim-rhubarb",
    config = function()
        vim.cmd[[
            function! s:quark(args, ...)
                if a:args ==# ""
                    return "topleft"
                endif
                return join(a:000, " ")
            endfunction
            command! -bang -nargs=? -range=-1 -complete=customlist,fugitive#Complete G
            \ exe fugitive#Command(<line1>, <count>, +"<range>", <bang>0, <SID>quark(<q-args>, <mods>), <q-args>)
        ]]
        vim.api.nvim_create_autocmd("Filetype", {
            pattern = "fugitive",
            callback = function()
                vim.keymap.set("n", "<tab>", "=", { buffer = true, remap = true })
            end,
        })
        vim.keymap.set("n", "<leader>dct", function()
            if vim.opt.diff == "diff" then
                return "<cmd>diffget //3<CR>"
            end
            return "<esc>"
        end, { desc = "Choose Theirs (//3)", expr = true } )
        vim.keymap.set("n", "<leader>dco", function()
            if vim.opt.diff == "diff" then
                return "<cmd>diffget //2<CR>"
            end
            return "<esc>"
        end, { desc = "Choose Ours (//2)", expr = true } )
    end
}
