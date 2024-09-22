local function term(mods, argument, title)
    vim.cmd(string.format("exec 'noa %s term %s' | startinsert", mods, argument))
    if title then
        vim.api.nvim_buf_set_name(0, title)
    end
    local winnr = vim.api.nvim_get_current_win()
    vim.wo[winnr].relativenumber = false
    vim.wo[winnr].signcolumn = "no"
    vim.wo[winnr].scrolloff = 0
    vim.wo[winnr].number = false
    vim.wo[winnr].spell = false
    vim.api.nvim_create_autocmd("TermClose", {
        once = true,
        buffer = vim.api.nvim_get_current_buf(),
        command = "bd!",
    })
end

local function tab_term(command, opts)
    if type(command) == "table" then
        command = table.concat(command, " ")
    end
    if type(command) ~= "string" then
        error "command should be string/table"
    end
    term("tab", command, opts.title)
end

local function clear_maps(bufnr, mode)
    local maps = nvim_get_keymap(mode)
    for _, map in ipairs(maps) do
        vim.keymap.set(mode, map.lhs, "<nop>", { buffer = bufnr })
    end
end

local function map_gen(default_opts)
    return function(modes, lhs, rhs, opts)
        opts = opts or {}
        local options = vim.tbl_deep_extend("keep", opts, default_opts)
        vim.keymap.set(modes, lhs, rhs, options)
    end
end

return {
    rooter = require("cathy.rooter"),
    tab_term = tab_term,
    clear_buf_maps = clear_maps,
    map_gen = map_gen
}
