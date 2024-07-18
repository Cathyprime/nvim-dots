local M = {}

local sub_word

local opts = {
    silent = true,
    expr = true
}

function M.substitute_confirm_callback()
    local input = vim.fn.input({
        cancelreturn = -99,
        prompt = "s/" .. sub_word .. "/"
    })
    if input == -99 then
        return
    end
    vim.cmd("'[,']s/" .. sub_word .. "/" .. input .. "/gc")
end

function M.substitute_callback()
    local input = vim.fn.input({
        cancelreturn = -99,
        prompt = "s/" .. sub_word .. "/"
    })
    if input == -99 then
        return
    end
    vim.cmd("'[,']s/" .. sub_word .. "/" .. input .. "/g")
end

function M.get_word(func, linewise)
    sub_word = vim.fn.expand("<cword>")
    vim.go.operatorfunc = func
    if linewise then
        return "g@_"
    else
        return "g@"
    end
end

vim.keymap.set("n", "gs", function()
    return M.get_word("v:lua.require'substitute'.substitute_callback", false)
end, opts)

vim.keymap.set("n", "gss", function()
    return M.get_word("v:lua.require'substitute'.substitute_callback", true)
end, opts)

vim.keymap.set("n", "gS", function()
    return M.get_word("v:lua.require'substitute'.substitute_confirm_callback", false)
end, opts)

vim.keymap.set("n", "gSS", function()
    return M.get_word("v:lua.require'substitute'.substitute_confirm_callback", true)
end, opts)

return M
