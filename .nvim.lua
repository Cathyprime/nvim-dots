-- harpoon those registers
local registers = {
	old = {},
	new = {
		["a"] = ":e plugin/autocmd.lua\n",
		["c"] = ":e plugin/commands.lua\n",
		["k"] = ":e plugin/keymaps.lua\n",
		["m"] = ":e lua/yoolayn/plugin/misc.lua\n",
		["o"] = ":e plugin/options.lua\n",
	}
}

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		local str = ""
		for reg, file in pairs(registers.new) do
			str = string.format("%s%s", str, reg)
			registers.old[reg] = vim.fn.getreg(reg)
			vim.fn.setreg(reg, file)
		end
		vim.keymap.set("n", "<leader>h", string.format("<cmd>reg %s<cr>", str), { silent = true })
	end
})


vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		for reg, content in pairs(registers.old) do
			print(reg, content)
			vim.fn.setreg(reg, content)
		end
	end
})
