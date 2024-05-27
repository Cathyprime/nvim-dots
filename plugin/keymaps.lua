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

local diag_active = true
local function diag_text_toggle()
    diag_active = not diag_active
    vim.diagnostic.config({ virtual_text = diag_active })
end

local function toggle_diagnostics()
    if vim.diagnostic.is_enabled() then
        vim.diagnostic.enable(false)
    else
        vim.diagnostic.enable(true)
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

-- quickfix commands
if vim.g.loaded_dispatch ~= 1 then
    map("n", "<leader>q", "<cmd>botright cope<cr>")
end
map("n", "]c", "<cmd>cnext<cr>")
map("n", "[c", "<cmd>cprev<cr>")

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
if MiniStarter ~= nil then
    map("n", "gh", MiniStarter.open)
end
map("n", "X", [[0"_D]])
map("x", "X", [[:norm 0"_D<cr>]])
map("n", "J", [[mmJ`m]])
map("n", "gp", "`[v`]")
map("n", "U", "<c-r>")
map("n", "j", function()
    return jump("j")
end, { expr = true })
map("n", "k", function()
    return jump("k")
end, { expr = true })
map("n", "<leader>oc", "<cmd>e .nvim.lua<cr>")
map("n", "<leader>ot", "<cmd>e todo.norg<cr>")
map("n", "<leader>os", "<cmd>Scratch<cr>")
map("n", "<leader>oS", "<cmd>Scratch sh<cr>")
map("x", "<leader>;", [[:<c-u>'<,'>norm A;<cr>]])
map("n", "<c-z>", "<Nop>")

-- diagnostic
map("n", "<leader>dl", diag_text_toggle)
map("n", "<leader>dt", toggle_diagnostics)
map("n", "<leader>dq", vim.diagnostic.setqflist)

-- command line
map("c", "<c-a>", "<home>", { silent = false })

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

-- quick search and replace keymaps
map("n", "<leader>ss", ":.,$s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>", { silent = false })
map("n", "<leader>sS", ":.,$s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>", { silent = false })
map("n", "<leader>Ss", ":%s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>", { silent = false })
map("n", "<leader>SS", ":%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>", { silent = false })

map("v", "<leader>s", [[y:s/<c-r>"/<c-r>"/gc<left><left><left>]], { silent = false })
map("v", "<leader>S", [[y:%s/<c-r>"/<c-r>"/gc<left><left><left>]], { silent = false })

map("v", "<leader>d", [[:s#\(\S\)\s\+#\1 #g<cr>:noh<cr>]])

-- esc will return to place before searching
map("n", "*", "mm*")
map("n", "#", "mm#")
map("n", "/", "mm/", { silent = false })
map("n", "?", "mm?", { silent = false })

-- map("v", "<leader>x", function()
--     local reg = vim.region(0, "v", ".", "", true)
--     MiniMisc.put(reg)
-- end)
