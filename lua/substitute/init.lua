local M = {}

local sub_word

local opts = {
    silent = true,
    expr = true
}

---@return nil
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

---@return nil
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

---@param func string
---@param linewise boolean?
---@return string
function M.get_word(func, linewise)
    sub_word = vim.fn.expand("<cword>")
    vim.go.operatorfunc = func
    if linewise then
        return "g@_"
    else
        return "g@"
    end
end

local cache = {
    query = "",
    replace = ""
}

---@return string
local function query_prompt()
    if cache.query == "" then
        return "Query replace in region: "
    else
        return "Query replace in region (default "..cache.query.." -> "..cache.replace.."): "
    end
end

local function replace_prompt(what)
    if cache.query == "" or what ~= cache.query then
        return "Query replace "..what.." with: "
    else
        return "Query replacing "..cache.query.." with "..cache.replace..": "
    end
end

---@return string?
function M.visual_replace()
    local query = vim.fn.input({
        cancelreturn = -99,
        prompt = query_prompt(),
    })
    if query == -99 then
        return
    end
    local replace = ""
    if query ~= "" then
        replace = vim.fn.input({
            cancelreturn = -99,
            prompt = replace_prompt(query ~= "" and query or cache.query),
        })
        if replace == -99 then
            return
        end
    end
    cache.query = query ~= "" and query or cache.query
    cache.replace = replace ~= "" and replace or cache.replace
    return string.format(":s/%s/%s/gc<cr>", cache.query, cache.replace)
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

vim.keymap.set("x", "gs", function() return M.visual_replace() end, opts)

return M
