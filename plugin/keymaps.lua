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
    local table = vim.api.nvim_list_bufs()
    for _, x in ipairs(table) do
        if vim.api.nvim_get_option_value("modified", { buf = x }) and vim.api.nvim_buf_is_loaded(x) then
            return true
        end
    end
    return false
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
local function diagnostic_toggle()
    diag_active = not diag_active
    vim.diagnostic.config({ virtual_text = diag_active })
end

local scroll
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        scroll = vim.opt.scrolloff
    end,
})
local function scrolloff_toggle()
    if vim.o.scrolloff == 0 then
        vim.opt["scrolloff"] = scroll
    else
        vim.o.scrolloff = 0
    end
end

local function add_harpoon()
    local input = vim.fn.nr2char(vim.fn.getchar())
    if not input:match("%a") then
        print("use only registers a-z")
        return
    end
    local cmd = string.format('let @%s = ":e %s\\n"', input, vim.fn.expand("%:p:~:."))
    vim.cmd(cmd)
end

-- macro
map("x", "@", function()
    return ":norm @" .. vim.fn.getcharstr() .. "<cr>"
end, { expr = true })
map("n", "gQ", "qqqqq") -- clear q register and start recording (useful for recursive macros)

-- quickfix commands
map("n", "<leader>q", "<cmd>botright cope<cr>")
map("n", "]c", "<cmd>cnext<cr>")
map("n", "[c", "<cmd>cprev<cr>")

-- scrolling
map("n", "<c-b>", "<Nop>")
map("n", "<c-f>", "<Nop>")

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

-- toggles
map("n", "<leader>tw", "<cmd>set wrap!<cr>")
map("n", "<leader>ts", scrolloff_toggle)

-- misc
map("n", "X", "0D")
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
map("x", "<leader>;", [[:<c-u>'<,'>norm A;<cr>]])
map("n", "<leader>a", add_harpoon)
map("n", "<leader>gl", function()
    vim.cmd("24sp | exec 'term lazygit -ucf ~/.config/nvim/lazygit/config.yml' | startinsert")
    vim.api.nvim_create_autocmd("TermClose", {
        once = true,
        buffer = vim.api.nvim_get_current_buf(),
        command = "close",
    })
end)

-- diagnostic
map("n", "<leader>dt", diagnostic_toggle)
map("n", "<leader>dq", vim.diagnostic.setqflist)

-- command line
map("c", "<c-a>", "<home>", { silent = false })

-- minibuffer
map("n", "<a-;>", "q:")

-- insert
map("i", "<c-a>", "<home>")
map("i", "<c-e>", "<end>")

-- quick search and replace keymaps
map("n", "<leader>s", ":%s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>", { silent = false })
map("n", "<leader>S", ":s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>", { silent = false })
map("v", "<leader>s", [[y:%s/<c-r>"/<c-r>"/gc<left><left><left>]], { silent = false })
map("v", "<leader>S", [[y:s/<c-r>"/<c-r>"/gc<left><left><left>]], { silent = false })

-- terminal
map("n", "<c-w>t", "<cmd>12Terminal<cr>")

-- neovide specific
if vim.g.neovide then
    map("n", "<c-z>", "<Nop>")
end
