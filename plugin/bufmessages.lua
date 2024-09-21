local BUFNAME = "Messages"
local TIMEOUT = 1000

---@alias bufnr integer

---@param bufnr bufnr
---@return nil
local function set_options(bufnr)
    vim.api.nvim_buf_set_name(bufnr, BUFNAME)
    vim.api.nvim_set_option_value("buftype", "nofile", { buf = bufnr })
    vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = bufnr })
    vim.api.nvim_set_option_value("modifiable", true, { buf = bufnr })
    vim.api.nvim_set_option_value("buflisted", false, { buf = bufnr })
    vim.api.nvim_set_option_value("swapfile", false, { buf = bufnr })
    vim.keymap.set("n", "gq", "<cmd>bd!<cr>", { buffer = bufnr, silent = true })
end

---@param bufnr bufnr
local function set_lines(bufnr)
    local new_messages = vim.api.nvim_cmd({ cmd = "messages" }, { output = true })
    if new_messages == "" then
        return
    end
    if not vim.api.nvim_buf_is_valid(bufnr) then
        return
    end

    local lines = vim.split(new_messages, "\n")
    local buf_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    if #lines <= #buf_lines then
        return
    end

    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end

---@return bufnr
local function create_messages_buffer()
    local bufnr = vim.api.nvim_create_buf(false, true)
    set_options(bufnr)
    set_lines(bufnr)
    return bufnr
end

---@param name string
---@return bufnr|nil
local function find_buffer_by_name(name)
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local buf_name = vim.api.nvim_buf_get_name(buf)
        if buf_name == name then
            return buf
        end
    end
end

vim.api.nvim_create_user_command(
    "Messages",
    function(opts)
        local buf = find_buffer_by_name(BUFNAME)
        if buf ~= nil then
            vim.api.nvim_buf_delete(buf)
        end
        vim.cmd(string.format(opts.mods.." sp | keepalt buffer %s", create_messages_buffer()))
    end,
    {}
)
