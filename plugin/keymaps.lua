vim.keymap.set("n", "<m-x>", function()
	vim.opt.cmdheight = 0
	return "q:i <BS>"
end, { expr = true })
