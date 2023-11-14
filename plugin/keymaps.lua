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

local function confirm_save(yes, no, question, err_question)
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
	if char == "y" then
		vim.cmd(yes)
	elseif char == "n" then
		vim.cmd(no)
	else
		vim.cmd("redraw!")
	end
end

-- minibuffer
map("n", "<m-x>", function()
	vim.opt.cmdheight = 0
	return "q:i <BS>"
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
	confirm_save("wqa", "qa!", "Save buffers? [y/n/q]", "Only [y/n/q]")
end)
map("n", "<c-x>c", function()
	confirm_save("wq", "q!", "Save buffer? [y/n/q]", "Only [y/n/q]")
end)

-- misc
map("n", "X", "0D")
map("n", "J", [[mzJ`z]])
map("n", "gp", "`[v`]")
map("n", "U", "<c-r>")
