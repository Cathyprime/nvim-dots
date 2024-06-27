local function start_wrapper()
    if vim.b["start_compile"] then
        return string.format("<cmd>Start -wait=always %s<cr>", vim.b["start_compile"])
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
    return string.format("<cmd>Start -wait=always %s<cr>", vim.b["start_compile"])
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
    return string.format("<cmd>Start -wait=always %s<cr>", c)
end

local function dispatch_wrapper()
    vim.g["dispatch_ready"] = true
    if vim.b["dispatch"] then
        return "<cmd>Dispatch!<cr>"
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
    return "<cmd>Dispatch!<cr>"
end

local function dispatch_wrapper_change()
    vim.g["dispatch_ready"] = true
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
    return "<cmd>Dispatch!<cr>"
end

local function make_wrapper()
    vim.g["dispatch_ready"] = true
    if vim.g["make_compile"] then
        return string.format("<cmd>Make! %s<cr>", vim.g["make_compile"])
    end
    local ok, c = pcall(vim.fn.input, {
        prompt = ":make ",
        default = vim.g["make_compile"] or "",
        cancelreturn = -99,
    })
    vim.cmd("redraw")
    if not ok or c == -99 then return "" end
    vim.g["make_compile"] = c
    return string.format("<cmd>Make! %s<cr>", c)
end

local function make_wrapper_change()
    vim.g["dispatch_ready"] = true
    if not vim.g["make_compile"] then
        return make_wrapper()
    end
    local ok, c = pcall(vim.fn.input, {
        prompt = ":make ",
        default = vim.g["make_compile"] or "",
        cancelreturn = -99,
        completion = "custom,v:lua.CustomFilesystemCompletion"
    })
    if not ok or c == -99 then return "" end
    vim.cmd("redraw")
    vim.g["make_compile"] = c
    return string.format("<cmd>Make! %s<cr>", c)
end

local function openqf()
    if vim.g.dispatch_ready then
        vim.g["dispatch_ready"] = false
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

return {
    "tpope/vim-dispatch",
    config = function()
        vim.keymap.set("n", "Zc",        "<cmd>AbortDispatch<cr>", { silent = true               })
        vim.keymap.set("n", "ZC",        "<cmd>AbortDispatch<cr>", { silent = true               })
        vim.keymap.set("n", "ZF",        "<cmd>Focus!<cr>",        { silent = true               })
        vim.keymap.set("n", "Zf",        ":Focus ",                { silent = false              })
        vim.keymap.set("n", "ZS",        start_wrapper_change,     { silent = false, expr = true })
        vim.keymap.set("n", "Zs",        start_wrapper,            { silent = false, expr = true })
        vim.keymap.set("n", "ZD",        dispatch_wrapper_change,  { silent = false, expr = true })
        vim.keymap.set("n", "Zd",        dispatch_wrapper,         { silent = false, expr = true })
        vim.keymap.set("n", "Zm",        make_wrapper,             { silent = false, expr = true })
        vim.keymap.set("n", "ZM",        make_wrapper_change,      { silent = false, expr = true })
        vim.keymap.set("n", "<leader>q", openqf,                   { silent = false, expr = true })
    end
}
