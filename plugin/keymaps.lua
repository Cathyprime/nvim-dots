local function map(modes, lhs, rhs, opts)
	opts = opts or {}
	local options = vim.tbl_deep_extend("keep", opts, { silent = true })
	vim.keymap.set(modes, lhs, rhs, options)
end

local function openqf()
	if vim.b.dispatch_ready == 1 then
		vim.b.dispatch_ready = 0
		return "<cmd>Cope<cr>"
	else
		return "<cmd>cope<cr>"
	end
end

local function getChar(question, err_question)
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
	local char = getChar(question, err)
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
		print(x)
		if vim.api.nvim_buf_get_option(x, 'modified') and vim.api.nvim_buf_is_loaded(x) then
			return true
		end
	end
	return false
end

local function confirm_save_all(question, err)
	if not find_if_modified() then
		vim.cmd("qa")
	end
	local char = getChar(question, err)
	if char == "y" then
		vim.cmd("wqa")
	elseif char == "n" then
		vim.cmd("qa!")
	else
		vim.cmd("redraw!")
	end
end

-- minibuffer
map("n", "<m-x>", function()
	vim.api.nvim_create_autocmd("CmdwinEnter", {
		once = true,
		callback = function()
			vim.o.laststatus = 0
			vim.opt_local.filetype = "minibuffer"
		end
	})
	vim.opt.cmdheight = 0
	return "q:"
end, { expr = true })

-- macro on lines
map("x", "@", function () return ":norm @" .. vim.fn.getcharstr() .. "<cr>" end, { expr = true })

-- quickfix commands
map("n", "<leader>q", openqf, { expr = true })
map("n", "]c", "<cmd>cnext<cr>")
map("n", "[c", "<cmd>cprev<cr>")

-- scrolling
map("n", "<c-b>", "<Nop>")
map("n", "<c-f>", "<Nop>")
map("n", "<c-d>", "<c-d>zz")
map("n", "<c-u>", "<c-u>zz")

-- text objects
-- inner underscore
map("o", "i_", ":<c-u>norm! T_vt_<cr>")
map("x", "i_", ":<c-u>norm! T_vt_<cr>")
-- a underscore
map("o", "a_", ":<c-u>norm! F_vf><cr>")
map("x", "a_", ":<c-u>norm! F_vf_<cr>")

-- clipboard
map({"n", "v"}, "<leader>y", [["+y]])
map({"n", "v"}, "<leader>Y", [["+Y]])
map({"n", "v"}, "<leader>p", [["+p]])
map({"n", "v"}, "<leader>P", [["+P]])

-- save
map("n", "<c-x><c-s>", "<cmd>write<cr>")
map("n", "<c-x><c-e>", "<cmd>source<cr>")
map("n", "<c-x><c-x>", "<c-x>")
map("n", "<c-x><c-c>", function()
	confirm_save_all("Save buffers? [y/n/q]", "Only [y/n/q]")
end)
map("n", "<c-x>c", function()
	confirm_save_cur("Save buffer? [y/n/q]", "Only [y/n/q]")
end)

-- misc
map("n", "X", "0D")
map("n", "J", [[mzJ`z]])
map("n", "gp", "`[v`]")
map("n", "U", "<c-r>")

-- command line
map("c", "<c-a>", "<home>")

-- quick search and replace keymaps
map("n", "<leader>s", ":%s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>", { silent = false })
map("n", "<leader>S", ":s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>", { silent = false })
map("v", "<leader>s", [[y:%s/<c-r>"/<c-r>"/gc<left><left><left>]], { silent = false })
map("v", "<leader>S", [[y:s/<c-r>"/<c-r>"/gc<left><left><left>]], { silent = false })
