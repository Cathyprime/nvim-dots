local Hydra = require("hydra")

Hydra({
	name = "Side scroll",
	mode = "n",
	body = "z",
	heads = {
		{ "h", "5zh" },
		{ "l", "5zl", { desc = "←/→" } },
		{ "H", "zH" },
		{ "L", "zL", { desc = "half screen ←/→" } },
		{ "<CR>", nil, { exit = true } },
		{ "q", nil, { exit = true, desc = "leave" } },
	},
	config = {
		timout = 500,
	},
})

Hydra({
	name = "Change window",
	mode = "n",
	body = "<C-w>",
	heads = {
		{ "<C-h>", "<C-w>h" },
		{ "<C-j>", "<C-w>j" },
		{ "<C-k>", "<C-w>k" },
		{ "<C-l>", "<C-w>l" },
		{ "C", "<C-w>c" },
	},
	config = {
		timout = 500,
	},
})

Hydra({
	name = "resize window",
	mode = "n",
	body = "<C-w>",
	heads = {
		{ "<", "<C-w><" },
		{ ">", "<C-w>>", { desc = "width" } },
		{ "+", "<C-w>+" },
		{ "-", "<C-w>-", { desc = "height" } },
		{ "=", "<C-w>=", { desc = "reset" } },
	},
	config = {
		timout = 500,
	},
})

local debug = Hydra({
	name = "debug",
	config = {
		color = "pink",
	},
	heads = {
		{"b", function() require("dap").toggle_breakpoint() end, {desc="toggle breakpoint"} },
		{"B", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, {desc = "break condition"}},
		{"l", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, {desc = "log"}},
		{"i", function() require("dap").step_into() end, {desc = "step into"}},
		{"o", function() require("dap").step_over() end, {desc = "step over"}},
		{"O", function() require("dap").step_out() end, {desc = "step out"}},
		{"u", function() require("dapui").toggle() end, {desc = "ui"}},
		{"c", function() require("dap").continue() end, {desc = "continue"}},
		{"<F2>", nil, {exit = true, desc = "leave"}},
	},
})
vim.keymap.set("n", "<F2>", function() debug:activate() end)

Hydra({
	name = "Git",
	mode = "n",
	body = "<leader>g",
	heads = {
		{"g", "<cmd>G<cr>"},
		{"p", "<cmd>G push<cr>"},
	},
	config = {
		timout = 499,
	},
})
