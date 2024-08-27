local M = {}

local opts = {
    silent = true,
    expr = true
}

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

local function replace_prompt()
    if cache.replace == "" then
        return "Query replace "..cache.query.." with: "
    else
        return "Query replacing "..cache.query.." with "..cache.replace..": "
    end
end

local function do_query()
    local query = vim.fn.input({
        cancelreturn = -99,
        prompt = query_prompt(),
    })
    if query == -99 then
        return
    end
    cache.query = query ~= "" and query or cache.query
end

local function do_replace()
    local replace = vim.fn.input({
        cancelreturn = -99,
        prompt = replace_prompt(),
    })
    if replace == -99 then
        return
    end
    cache.replace = replace ~= "" and replace or cache.replace
end

---@param func string
---@param linewise boolean?
---@return string
function M.get_word(func, linewise)
    vim.go.operatorfunc = func
    if linewise then
        return "g@_"
    else
        return "g@"
    end
end

---@return nil
function M.substitute_callback_half_ass()
    do_replace()
    vim.cmd(string.format(":'[,']s/%s/%s/ge", cache.query, cache.replace))
    vim.cmd("stopinsert")
end

function M.substitute_callback()
    do_query()
    do_replace()
    vim.cmd(string.format(":'[,']s/%s/%s/ge", cache.query, cache.replace))
    vim.cmd("stopinsert")
    vim.go.operatorfunc = "v:lua.require'substitute'.substitute_callback_half_ass"
    return 'g@'
end

---@return string?
function M.visual_replace()
    do_query()
    do_replace()
    return string.format(":s/%s/%s/gc<cr>", cache.query, cache.replace)
end

vim.keymap.set("n", "gs", function()
    return M.get_word("v:lua.require'substitute'.substitute_callback", false)
end, opts)

vim.keymap.set("n", "gss", function()
    return M.get_word("v:lua.require'substitute'.substitute_callback", true)
end, opts)

vim.keymap.set("x", "gs", function() return M.visual_replace() end, opts)

return M
