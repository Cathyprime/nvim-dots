return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "gu", function()
            if vim.o.diff == "diff" then
                return "<cmd>diffget //2<CR>"
            end
            return "<esc>"
        end, { expr = true })
        vim.keymap.set("n", "gh", function()
            if vim.o.diff == "diff" then
                return "<cmd>diffget //3<CR>"
            end
            return "<esc>"
        end, { expr = true })
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
                vim.keymap.set("n", "<tab>", "<cmd>execute <SNR>58_StageInline('toggle',line('.'),v:count)<CR>", { buffer = true })
            end,
        })
    end
}
