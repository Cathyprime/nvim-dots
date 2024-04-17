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
