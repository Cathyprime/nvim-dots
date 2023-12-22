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

local function openqf()
	if vim.b.dispatch_ready then
		vim.b["dispatch_ready"] = false
		return "<cmd>Cope<cr>"
	else
		return "<cmd>botright cope<cr>"
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

local function DispatchWrapper()
	vim.b["dispatch_ready"] = true
	if vim.b.dispatch then
		return ":Dispatch!<cr>"
	end
	local c = vim.fn.input(":Dispatch ")
	vim.cmd"redraw"
	vim.b["dispatch"] = c
	return ":Dispatch!<cr>"
end

local function DispatchWrapperChange()
	vim.b["dispatch_ready"] = true
	if not vim.b.dispatch then
		return DispatchWrapper()
	end
	local c = vim.fn.input(":Dispatch ")
	vim.cmd"redraw"
	vim.b["dispatch"] = c
	return ":Dispatch!<cr>"
end

local function MakeWrapper()
	vim.b["dispatch_ready"] = true
	local c = vim.fn.input(":make ")
	vim.cmd"redraw"
	return ":Make! " .. c .. "<cr>"
end

-- Compilation
map("n", "<c-c>s", ":Start ", { silent = false })
map("n", "<c-c>f", ":Focus ", { silent = false })
map("n", "<c-c>F", ":Focus!<cr>")
map("n", "<c-c>d", DispatchWrapper, { expr = true, silent = false })
map("n", "<c-c>D", DispatchWrapperChange, { expr = true, silent = false })
map("n", "<c-c>m", MakeWrapper, { expr = true, silent = false })

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
map({"n", "v"}, "<leader>Y", [["+y$]])
map({"n", "v"}, "<leader>p", [["+p]])
map({"n", "v"}, "<leader>P", [["+P]])

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
map("n", "X", "0D")
map("n", "J", [[mzJ`z]])
map("n", "gp", "`[v`]")
map("n", "U", "<c-r>")
map("n", "j", function()
	return jump("j")
end, { expr = true })
map("n", "k", function()
	return jump("k")
end, { expr = true })

-- command line
map("c", "<c-a>", "<home>")

-- quick search and replace keymaps
map("n", "<leader>s", ":%s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>", { silent = false })
map("n", "<leader>S", ":s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>", { silent = false })
map("v", "<leader>s", [[y:%s/<c-r>"/<c-r>"/gc<left><left><left>]], { silent = false })
map("v", "<leader>S", [[y:s/<c-r>"/<c-r>"/gc<left><left><left>]], { silent = false })

-- splits
for _, v in ipairs({"<c-w>t", "<c-w>T"}) do
	map("n", v, function()
		if vim.v.count == 0 then
			vim.cmd("split")
		else
			local height = vim.api.nvim_win_get_height(0) - vim.v.count - 1
			local cmd
			if v == "<c-w>t" then
				cmd = ""
			else
				cmd = "above"
			end
			vim.cmd(cmd .. height .. "split")
		end
	end)
end
