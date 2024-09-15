local function map(modes, lhs, rhs, opts)
    opts = opts or {}
    local options = vim.tbl_deep_extend("keep", opts, { silent = true })
    vim.keymap.set(modes, lhs, rhs, options)
end

local function jump(direction)
    local ret = ""
    if vim.v.count > 1 then
        ret = "m'" .. vim.v.count
    end
    return ret .. direction
end

local function get_char(question, err_question)
    local char
    while true do
        print(question)
        char = vim.fn.nr2char(vim.fn.getchar())
        if char == "y" or char == "n" or char == "q" then
            break
        else
            print(err_question)
            vim.cmd("sleep 300m")
        end
    end
    return char
end

local function confirm_save_cur(question, err)
    if not vim.opt_local.modified:get() then
        vim.cmd("q")
        return
    end
    local char = get_char(question, err)
    if char == "y" then
        vim.cmd("wq")
    elseif char == "n" then
        vim.cmd("q!")
    else
        vim.cmd("redraw!")
    end
end

local function find_if_modified()
    return vim.iter(vim.api.nvim_list_bufs()):any(function(buffer)
        return vim.api.nvim_get_option_value("modified", { buf = buffer }) and vim.api.nvim_buf_is_loaded(buffer)
    end)
end

local function confirm_save_all(question, err)
    if not find_if_modified() then
        vim.cmd("qa")
    end
    local char = get_char(question, err)
    if char == "y" then
        vim.cmd("wqa")
    elseif char == "n" then
        vim.cmd("qa!")
    else
        vim.cmd("redraw!")
    end
end

-- macro
vim.keymap.set("x", "@", function()
    local char = vim.fn.nr2char(vim.fn.getchar())
    vim.api.nvim_feedkeys(vim.keycode"<ESC>", 'x', false)
    local start = vim.fn.getpos("'<")[2]
    local stop = vim.fn.getpos("'>")[2]
    local ns = vim.api.nvim_create_namespace("macro_lines")
    for x = start,stop do
        vim.api.nvim_buf_set_extmark(0, ns, x, 0, {
            id = x + 1
        })
    end
    local function consume_marks(marks)
        if #marks == 0 then return end
        local cur = marks[1]
        vim.api.nvim_buf_del_extmark(0, ns, cur[1])
        vim.schedule(function()
            vim.cmd(cur[2] .. "norm @" .. char)
        end)
        vim.schedule(function()
            consume_marks(vim.api.nvim_buf_get_extmarks(0, ns, 0, -1, {}))
        end)
    end
    local x = vim.api.nvim_buf_get_extmarks(0, ns, 0, -1, {})
    consume_marks(x)
end)

map("n", "gQ", "qqqqq") -- clear q register and start recording (useful for recursive macros)

-- matchit plugin descriptions
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        map("n", "]%", "<Plug>(MatchitNormalMultiForward)", { desc = "Next unmatched group" })
        map("n", "[%", "<Plug>(MatchitNormalMultiBackward)", { desc = "Prev unmatched group" })
    end,
})

-- quickfix commands
if vim.g.loaded_dispatch ~= 1 then
    map("n", "<leader>q", "<cwd>cope<cr>")
end
if not package.loaded["demicolon"] then
    map("n", "]c", "<Plug>(qf_qf_next)", { desc = "Next quickfix item" })
    map("n", "[c", "<Plug>(qf_qf_previous)", { desc = "Prev quickfix item" })
    map("n", "]C", "<Plug>(qf_qf_previous)", { desc = "Prev quickfix item" })
    map("n", "[C", "<Plug>(qf_qf_next)", { desc = "Next quickfix item" })
end

-- scrolling
map("n", "<c-b>", "<Nop>")

-- text objects
-- inner underscore
map("o", "i_", ":<c-u>norm! T_vt_<cr>")
map("x", "i_", ":<c-u>norm! T_vt_<cr>")
-- a underscore
map("o", "a_", ":<c-u>norm! F_vf><cr>")
map("x", "a_", ":<c-u>norm! F_vf_<cr>")

-- clipboard
map({ "n", "v" }, "<leader>y", [["+y]])
map({ "n", "v" }, "<leader>gy", "<cmd>:%y+<cr>")
map({ "n", "v" }, "<leader>Y", [["+y$]])
map({ "n", "v" }, "<leader>p", [["+p]])
map({ "n", "v" }, "<leader>P", [["+P]])

-- save
map("n", "ZW", "<cmd>write<cr>")
-- map("n", "ZE", "<cmd>source<cr>")
map("n", "ZZ", function()
    confirm_save_all("Save buffers? [y/n/q]", "Only [y/n/q]")
end)
map("n", "ZQ", function()
    confirm_save_cur("Save buffer? [y/n/q]", "Only [y/n/q]")
end)

-- misc
map("n", "U", "<cmd>:earlier 1f<cr>")
map("n", "X", [[0"_D]])
map("x", "X", [[:norm 0"_D<cr>]])
map("n", "gp", "`[v`]")
map("n", "j", function()
    return jump("gj")
end, { expr = true })
map("n", "k", function()
    return jump("gk")
end, { expr = true })
map("n", "<leader>ot", "<cmd>e todo.md<cr>")
map("n", "<leader>oe", ":e <c-r>=expand('%:p:h') . '/'<cr>", { silent = false })
map("x", "<leader>;", [[<cmd>'<,'>norm A;<cr>]])
map("n", "<c-z>", "<Nop>")
map("n", "<leader>b", function()
    local char = vim.fn.nr2char(vim.fn.getchar())
    return string.format("<cmd>call setreg('%s', getreg('%s'), 'b')<cr>", char, char)
end, { expr = true, desc = "change register to block mode" })

if package.loaded["rooter"] then
    map("n", "<leader>r", function()
        vim.cmd.Rooter("toggle")
        vim.cmd.Rooter()
    end)
end

-- diagnostic
-- map("n", "<leader>dt", toggle_diagnostics, { desc = "toggle diagnostics display" })
-- map("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "show diagnostics in quickfix" })

-- command line
map("c", "<c-a>", "<home>", { silent = false })
map("c", "<m-f>", "<c-right>", { silent = false })
map("c", "<m-b>", "<c-left>", { silent = false })

-- minibuffer
map("n", "q:", function()
    vim.opt.foldmethod = "manual"
    return "q:"
end, { expr = true })

vim.api.nvim_create_autocmd("RecordingEnter", {
    once = false,
    callback = function()
        vim.keymap.del("n", "q:")
    end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
    once = false,
    callback = function()
        map("n", "q:", function()
            vim.opt.foldmethod = "manual"
            return "q:"
        end, { expr = true })
    end,
})

map("c", "<c-f>", function()
    vim.opt.foldmethod = "manual"
    return "<c-f>"
end, { expr = true })
map("c", "<space>", function()
    local cmdtype = vim.fn.getcmdtype()
    if cmdtype == "/" or cmdtype == "?" then
        return ".*"
    end
    return "<space>"
end, { silent = false, expr = true })
vim.keymap.set("ca", "G", "Git")

-- quick search and replace keymaps
require("cathy.substitute")
-- map("v", "gs", [[y:.,$s/<c-r>"/<c-r>"/gc<left><left><left>]], { silent = false })
-- map("v", "gS", [[y:%s/<c-r>"/<c-r>"/gc<left><left><left>]], { silent = false })

map("v", "<leader>d", [[:s#\(\S\)\s\+#\1 #g<cr>:noh<cr>]])

-- terminal
map("t", "<esc><esc>", [[<c-\><c-n>]])
map("t", "<m-w>", [[<c-\><c-n><c-w>w]])

if vim.g.neovide then
    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-+>", function()
        change_scale_factor(1.05)
    end)
    vim.keymap.set("n", "<C-=>", function()
        vim.g.neovide_scale_factor = 1.0
    end)
    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1/1.05)
    end)
end
