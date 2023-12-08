vim.api.nvim_create_user_command(
	"Messages",
	"let output = [] | redir => output | silent messages | redir END | cexpr output",
	{}
)
vim.api.nvim_create_user_command(
	"Scratch",
	function(opts)
		if not opts.bang then
			vim.cmd(opts.mods .. " split")
		end
		vim.cmd"enew"
		vim.api.nvim_set_option_value("buftype", "nofile", { buf = 0 })
		vim.api.nvim_set_option_value("bufhidden", "hide", { buf = 0 })
		vim.api.nvim_set_option_value("swapfile", false, { buf = 0 })
	end,
	{ bang = true }
)
