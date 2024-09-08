local M = {}

local opts = {
    silent = true,
    expr = true
}

local cache = {
    query = "",
    replace = "",
    use_abolish = true,
}

local formats = {
    visual = ":s/%s/%s/gec<cr>",
    visual_abolish = ":S/%s/%s/gec<cr>",
    normal = [['[,']s/%s/%s/gec]],
    normal_abolish = [['[,']S/%s/%s/gec]],
}

local function get_placeholder(visual)
    if visual then
        return cache.use_abolish and formats.visual_abolish or formats.visual
    else
        return cache.use_abolish and formats.normal_abolish or formats.normal
    end
end

local function abolish()
    vim.notify(cache.use_abolish and "Using abolish" or "Using default", vim.log.levels.INFO)
end

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
    local buf = vim.api.nvim_get_current_buf()
    vim.keymap.set("c", "<c-g>", function()
        cache.use_abolish = not cache.use_abolish
        abolish()
    end, { buffer = buf })

    local ok, query = pcall(vim.fn.input, {
        cancelreturn = -99,
        prompt = query_prompt(),
    })

    vim.keymap.del("c", "<c-g>", { buffer = buf })

    if not ok or query == -99 then
        return false
    end
    cache.query = query ~= "" and query or cache.query
    return true
end

local function do_replace()
    local ok, replace = pcall(vim.fn.input, {
        cancelreturn = -99,
        prompt = replace_prompt(),
    })
    if not ok or replace == -99 then
        return false
    end
    cache.replace = replace ~= "" and replace or cache.replace
    return true
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
    vim.cmd(string.format(get_placeholder(false), cache.query, cache.replace))
    vim.cmd("stopinsert")
end

function M.substitute_callback()
    if do_query() then
        do_replace()
    else
        return "<esc>"
    end
    vim.cmd(string.format(get_placeholder(false), cache.query, cache.replace))
    vim.cmd("stopinsert")
    vim.go.operatorfunc = "v:lua.require'cathy.substitute'.substitute_callback_half_ass"
    return 'g@'
end

---@return string?
function M.visual_replace()
    if not do_query() then
        return "<esc>"
    end
    if not do_replace() then
        return "<esc>"
    end
    return string.format(get_placeholder(true), cache.query, cache.replace)
end

vim.keymap.set("n", "gs", function()
    return M.get_word("v:lua.require'cathy.substitute'.substitute_callback", false)
end, opts)

vim.keymap.set("n", "gss", function()
    return M.get_word("v:lua.require'cathy.substitute'.substitute_callback", true)
end, opts)

vim.keymap.set("x", "gs", function() return M.visual_replace() end, opts)

return M
