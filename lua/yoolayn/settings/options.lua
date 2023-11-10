local M = {}

M.options = {
	rnu  =  true,
	nu  =  true,
	spell  =  true,
	spl = "en_us,en_gb,pl",
	tabstop = 4,
	shiftwidth = 4,
	smartindent = true,
	exrc = true,
	list = true,
	listchars = {
		append = "trail:-,tab:\\u0020\\u0020",
	},
	path = ".,**",
	ignorecase = false,
	smartcase = true,
	incsearch = true,
	hls = true,
	cursorline = true,
	guicursor = "i-ci-ve:block",
	showtabline = 0,
	scrolloff = 6,
	termguicolors = true,
	signcolumn = "yes",
	inccommand = "split",
	splitright = true,
	splitbelow = true,
	timeoutlen = 10000,
	updatetime = 50,
	swapfile = false,
	writebackup = false,
	shortmess = {
	append = "c",
	},
	showmode = false,
	laststatus = 3,
	undofile = true,
	undodir = os.getenv("HOME") .. "/.config/nvim/undo",
	wildmode = "longest:full,full",
	completeopt = "menu",
	winminwidth = 5,
	pumheight = 6,
	wrap = false,
}

M.prg = {
	grep = "rg --vimgrep --no-heading --smart-case",
}

M.globals = {
	markdown_recommended_style = 0,
	loaded_netrw = 1,
	loaded_netrwPlugin = 1,
}

return M
