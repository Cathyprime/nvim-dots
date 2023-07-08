vim.g.mapleader = " "

local function map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	-- do not create the keymap if a lazy keys handler exists
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		opts = opts or {}
		opts.silent = opts.silent ~= false
		if opts.remap and not vim.g.vscode then
			opts.remap = nil
		end
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

local wk = require("which-key").register

-- leader
vim.g.mapleader = " "

-- system keyboard
wk({
	K = {
		name = "Keyboard",
		y = { '"+y', "yank to system keyboard" },
		Y = { '"+Y', "yank line to system keyboard" },
		d = { '"+d', "cut to system keyboard" },
		D = { '"+D', "cut line to system keyboard" },
		p = { '"+p', "paste from system keyboard" },
		P = { '"+P', "paste from system keyboard before" },
	},
}, {
	prefix = "<leader>",
	mode = { "n", "v" },
})

-- telescope
map("n", "<Leader>fs", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
map("n", "<Leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help Tags" })

-- undo tree
map("n", "<F5>", "<cmd>UndotreeToggle<CR>", { noremap = true, silent = true })
