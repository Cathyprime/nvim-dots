vim.api.nvim_create_user_command(
	"Messages",
	[[let output = [] | redir => output | silent messages | redir END | cexpr output]],
	{}
)

vim.api.nvim_create_user_command(
	"Delview",
	function()
		local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
		if path == nil then
			print("error getting path")
			return
		end
		path = vim.fn.substitute(path, "=", "==", "g")
		if path == nil then
			print("substitute error")
			return
		end
		path = vim.fn.substitute(path, "^" .. os.getenv("HOME"), "\\~", "")
		if path == nil then
			print("substitute error")
			return
		end
		path = vim.fn.substitute(path, "/", "=+", "g") .. "="
		local file_path = vim.opt.viewdir:get() .. path
		local int = vim.fn.delete(file_path)
		if int == -1 then
			print("View not found!")
		else
			print("deleted view:", file_path)
		end
	end,
	{}
)

vim.api.nvim_create_user_command(
	"Scratch",
	function(opts)
		local ft
		if opts.args ~= nil then
			local args = vim.split(opts.args, " ")[1]
			ft = args
		else
			ft = vim.api.nvim_get_option_value("filetype", {
				buf = 0,
			})
		end
		print(opts.args)
		if not opts.bang then
			vim.cmd(opts.mods .. " split")
		end
		vim.cmd"enew"
		vim.api.nvim_set_option_value("buftype", "nofile", { buf = 0 })
		vim.api.nvim_set_option_value("bufhidden", "hide", { buf = 0 })
		vim.api.nvim_set_option_value("swapfile", false, { buf = 0 })
		vim.api.nvim_set_option_value("filetype", ft, { buf = 0 })
	end,
	{
		bang = true,
		nargs = '?'
	}
)

local status = true

vim.api.nvim_create_user_command(
	"Presentation",
	function()
		if status then
			vim.opt_global.laststatus = 0
			vim.opt_global.cmdheight = 0
			vim.fn.system("tmux set -g status off")
			vim.opt.nu = false
			vim.opt.rnu = false
			status = false
			if vim.g.neovide then
				vim.opt.guifont = "JetBrainsMono NFM:h20"
			end
		else
			vim.opt_global.laststatus = 3
			vim.opt_global.cmdheight = 1
			vim.fn.system("tmux set -g status on")
			status = true
			vim.opt.nu = true
			vim.opt.rnu = true
			if vim.g.neovide then
				vim.opt.guifont = "JetBrainsMono NFM"
			end
		end
	end,
	{ nargs = 0 }
)
