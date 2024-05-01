local function augroup(name)
    return vim.api.nvim_create_augroup("cathy_" .. name, { clear = true })
end

-- start minibuffer
vim.api.nvim_create_autocmd("CmdwinEnter", {
    once = false,
    group = augroup("minibuffer"),
    callback = function()
        vim.opt_local.filetype = "minibuffer"
    end
})

-- Load view
vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*.*",
    callback = function() vim.cmd.loadview({ mods = { emsg_silent = true } }) end,
    group = augroup("Load view"),
})

-- terminal settings
vim.api.nvim_create_autocmd("TermOpen", {
    group = augroup("terminal"),
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.spell = false
        vim.opt_local.signcolumn = "no"
        vim.opt_local.scrolloff = 0
        vim.keymap.set("t", "<esc><esc>", [[<c-\><c-n>]], { buffer = true })
    end
})

-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank({ higroup = "SLNormal" })
    end,
})

-- close with q
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "help",
        "lspinfo",
        "man",
        "tsplayground",
        "checkhealth",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set(
            "n",
            "q",
            "<cmd>close<cr>",
            { buffer = event.buf, silent = true }
        )
    end,
})

-- create folder in-between
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("auto_create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- set filetype c for header and .c files instead of c++
vim.api.nvim_create_autocmd({"BufRead", "BUfNewFile"}, {
    group = augroup("c_filetypes"),
    once = false,
    pattern = {"*.c", "*.h"},
    command = "set ft=c",
})
