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

function _G.CustomFilesystemCompletion(arg_lead)
    local split = vim.split(arg_lead, " ") or { "" }

    local arg = table.remove(split, #split)
    local lead = table.concat(split, " ")

    local glob = vim.fn.glob(vim.fn.getcwd() .. "/" .. arg .. "*", true, true)
    return vim.iter(glob)
        :map(function(file)
            file = file:gsub(vim.fn.getcwd() .. "/", "")
            return file
        end)
        :map(function(file)
            if lead == "" then
                return file
            end
            return lead .. " " .. file
        end)
        :join("\n")
end
