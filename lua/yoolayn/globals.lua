P = function(table)
    print(vim.inspect(require(table)))
    return require(table)
end

R = function(module)
    package.loaded[module] = nil
    return require(module)
end
