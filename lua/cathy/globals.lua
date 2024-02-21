P = function(v)
    print(vim.inspect(v))
    return v
end

RELOAD = function(...)
    local ok, plenary_reload = pcall(require, "plenary.reload")
    if ok then
        local reloader = plenary_reload.reload_module
        return reloader(...)
    end
end

R = function(name)
    RELOAD(name)
    return require(name)
end

function _G.treesitter_foldtext()
    -- vim.treesitter.foldtext() will be removed at a later date
    local text = vim.treesitter.foldtext()
    ---@diagnostic disable-next-line
    table.insert(text, { " ...", {} })
    return text
end
