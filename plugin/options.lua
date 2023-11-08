local options = require("yoolayn.settings.options")

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
