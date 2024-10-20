local map = require("cathy.utils").map_gen({ silent = true })

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
-- if not package.loaded["demicolon"] then
--     map("n", "]c", "<Plug>(qf_qf_next)", { desc = "Next quickfix item" })
--     map("n", "[c", "<Plug>(qf_qf_previous)", { desc = "Prev quickfix item" })
--     map("n", "]C", "<Plug>(qf_qf_previous)", { desc = "Prev quickfix item" })
--     map("n", "[C", "<Plug>(qf_qf_next)", { desc = "Next quickfix item" })
-- end

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
map("x", "<leader>;", [[<cmd>'<,'>norm A;<cr>]])
map("n", "<c-z>", "<Nop>")
map("n", "<leader>ff", "<cmd>FindFile<cr>", { silent = false })

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

vim.keymap.set("ca", "G", "Git")
map("c", "<c-t>", function()
    local cmdtype = vim.fn.getcmdtype()
    if cmdtype == "/" or cmdtype == "?" then
        return ".\\{-}"
    end
    return
end, { silent = false, expr = true })

map("v", "<leader>d", [[:s#\(\S\)\s\+#\1 #g<cr>:noh<cr>]])

-- search
vim.api.nvim_create_autocmd("CursorHold", { command = "set nohlsearch" })
local function wrap(str, ret)
    return function()
        local old_wrapscan = vim.opt.wrapscan
        vim.opt.hlsearch = true
        vim.opt.wrapscan = false
        local ok = pcall(vim.cmd, string.format("silent normal! %s", str))
        if ok then
            vim.cmd(string.format("silent normal! %s", ret))
        end
        vim.opt.wrapscan = old_wrapscan
    end
end
local function wrap_fn(str, meow)
    return function()
        return string.format("<cmd>set hlsearch<cr><cmd>silent! normal! %s<cr>", str(meow))
    end
end
local function stable_search(forward)
    return forward
        and (vim.v.searchforward == 1 and "n" or "N")
        or (vim.v.searchforward == 0 and "n" or "N")
end
vim.keymap.set("n", "/", "<cmd>set hlsearch<cr>/")
vim.keymap.set("n", "?", "<cmd>set hlsearch<cr>?")
vim.keymap.set("n", "*", wrap("*", "N"), { silent = true })
vim.keymap.set("n", "g*", wrap("g*", "N"), { silent = true })
vim.keymap.set("n", "#", wrap("#", "n"), { silent = true })
vim.keymap.set("n", "g#", wrap("g#", "n"), { silent = true })
vim.keymap.set("n", "n", wrap_fn(stable_search, true), { silent = true, expr = true })
vim.keymap.set("n", "N", wrap_fn(stable_search, false), { silent = true, expr = true })

if vim.g.neovide then
    local change_scale_factor = function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    local function resize(lhs, delta)
        vim.keymap.set("n", lhs, function()
            if delta == 1.0 then
                vim.g.neovide_scale_factor = 1.0
                return
            end
            vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
        end)
    end
    resize("<c-+>", 1.05)
    resize("<c-->", 1/1.05)
    resize("<c-ScrollWheelUp>", 1.15)
    resize("<c-ScrollWheelDown>", 1/1.15)
    resize("<C-=>", 1.0)
end
