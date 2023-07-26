local function augroup(name)
    return vim.api.nvim_create_augroup("yoolayn_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({
    "CursorMoved",
    "ModeChanged",
    "WinLeave",
}, {
    group = vim.api.nvim_create_augroup("Minintro-hide", { clear = true }),
    callback = function()
        vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(false, true))
        vim.api.nvim_clear_autocmds({ group = "Minintro-hide" })
    end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    callback = function()
        if vim.bo.filetype == "help" then
            vim.cmd("wincmd L")
        end
    end,
})

vim.api.nvim_create_autocmd("RecordingEnter", {
    group = augroup("MacroMessageOn"),
    callback = function()
        vim.notify("Recording started!")
    end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
    group = augroup("MacroMessageOff"),
    callback = function()
        vim.notify("Recording ended!")
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "neotest-output",
        "checkhealth",
        "neotest-summary",
        "neotest-output-panel",
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
