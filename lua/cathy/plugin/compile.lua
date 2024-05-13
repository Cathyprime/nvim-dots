require("mini.deps").add("tpope/vim-dispatch")

local function start_wrapper()
    if vim.b["start_compile"] then
        return ":Start -wait=always " .. vim.b["start_compile"] .. "<cr>"
    end
    local ok, c = pcall(vim.fn.input, {
        prompt = ":Start ",
        default = vim.b["start_compile"] or "",
        cancelreturn = -99,
        completion = "custom,v:lua.CustomFilesystemCompletion"
    })
    if c == -99 or not ok then return "" end
    vim.cmd("redraw")
    vim.b["start_compile"] = c
    return ":Start -wait=always " .. vim.b["start_compile"] .. "<cr>"
end

local function start_wrapper_change()
    if not vim.b["start_compile"] then
        return start_wrapper()
    end
    local ok, c = pcall(vim.fn.input, {
        prompt = ":Start ",
        default = vim.b["start_compile"] or "",
        cancelreturn = -99,
        completion = "custom,v:lua.CustomFilesystemCompletion"
    })
    if not ok or c == -99 then return "" end
    vim.cmd("redraw")
    vim.b["start_compile"] = c
    return ":Start -wait=always " .. c .. "<cr>"
end

local function dispatch_wrapper()
    vim.b["dispatch_ready"] = true
    if vim.b["dispatch"] then
        return ":Dispatch!<cr>"
    end
    local ok, c = pcall(vim.fn.input, {
        prompt = ":Compile command ",
        default = vim.b.dispatch or "",
        cancelreturn = -99,
        completion = "custom,v:lua.CustomFilesystemCompletion"
    })
    if c == -99 or not ok then return "" end
    vim.cmd("redraw")
    vim.b["dispatch"] = c
    return ":Dispatch!<cr>"
end

local function dispatch_wrapper_change()
    vim.b["dispatch_ready"] = true
    if not vim.b.dispatch then
        return dispatch_wrapper()
    end
    local ok, c = pcall(vim.fn.input, {
        prompt = ":Compile command ",
        default = vim.b.dispatch or "",
        cancelreturn = -99,
        completion = "custom,v:lua.CustomFilesystemCompletion"
    })
    if not ok or c == -99 then return "" end
    vim.cmd("redraw")
    vim.b["dispatch"] = c
    return ":Dispatch!<cr>"
end

local function make_wrapper()
    vim.b["dispatch_ready"] = true
    local ok, c = pcall(vim.fn.input, {
        prompt = ":make ",
        default = vim.b.dispatch or "",
        cancelreturn = -99,
    })
    vim.cmd("redraw")
    if not ok or c == -99 then return "" end
    return ":Make! " .. c .. "<cr>"
end
local function openqf()
    if vim.b.dispatch_ready then
        vim.b["dispatch_ready"] = false
        return "<cmd>botright Cope<cr>"
    else
        return "<cmd>botright cope<cr>"
    end
end

vim.g.dispatch_handlers = {
    "terminal",
    "headless",
    "job",
}

vim.keymap.set("n", "Zc",        ":AbortDispatch<cr>",    { silent = true                 })
vim.keymap.set("n", "ZC",        ":AbortDispatch<cr>",    { silent = true                 })
vim.keymap.set("n", "Zf",        ":Focus ",               { silent = false                })
vim.keymap.set("n", "ZF",        ":Focus!<cr>",           { silent = true                 })
vim.keymap.set("n", "ZS",        start_wrapper_change,    { silent = false, expr = true   })
vim.keymap.set("n", "Zs",        start_wrapper,           { silent = false, expr = true   })
vim.keymap.set("n", "ZD",        dispatch_wrapper_change, { silent = false, expr = true   })
vim.keymap.set("n", "Zd",        dispatch_wrapper,        { silent = false, expr = true   })
vim.keymap.set("n", "ZM",        make_wrapper,            { silent = false, expr = true   })
vim.keymap.set("n", "<leader>q", openqf,                  { silent = false, expr = true   })
