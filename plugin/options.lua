local options = {}

options.options = {
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
	scrolloff = 8,
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
	completeopt = "menu,noselect",
	winminwidth = 5,
	pumheight = 6,
	wrap = false,
}

options.prg = {
	grep = "rg --vimgrep --no-heading --smart-case",
}

options.globals = {
	markdown_recommended_style = 0,
	loaded_netrw = 1,
	loaded_netrwPlugin = 1,
}







local function set_option(name, opts)
	local obj = vim.opt[name]
	for func, value in pairs(opts) do
		obj[func](obj, value)
	end
end

for key, value in pairs(options.prg) do
	key = key .. "prg"
	vim.opt[key] = value
end

for key, value in pairs(options.globals) do
	vim.g[key] = value
end

for key, value in pairs(options.options) do
	if type(value) ~= "table" then
		vim.opt[key] = value
	else
		set_option(key, value)
	end
end
