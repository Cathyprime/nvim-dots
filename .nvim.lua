-- harpoon those registers
local registers = {
	old = {},
	new = {
		["a"] = ":e plugin/autocmd.lua\n",
		["c"] = ":e plugin/commands.lua\n",
		["n"] = ":e .nvim.lua\n",
		["k"] = ":e plugin/keymaps.lua\n",
		["m"] = ":e lua/yoolayn/plugin/misc.lua\n",
		["o"] = ":e plugin/options.lua\n",
	}
}

for reg, file in pairs(registers.new) do
	registers.old[reg] = vim.fn.getreg(reg)
	vim.fn.setreg(reg, file)
end

vim.api.nvim_create_autocmd("VimLeavePre", {
	once = false,
	callback = function()
		for reg, content in pairs(registers.old) do
			vim.fn.setreg(reg, content)
		end
	end
})
