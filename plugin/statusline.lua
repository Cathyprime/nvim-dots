local modes = {
	["n"] =       { str = "[ Normal ]", highlight = "SLNormal"},
	["niI"] =     { str = "[ Normal ]", highlight = "SLNormal"},
	["niR"] =     { str = "[ Normal ]", highlight = "SLNormal"},
	["niV"] =     { str = "[ Normal ]", highlight = "SLNormal"},
	["nt"] =      { str = "[ Normal ]", highlight = "SLNormal"},
	["ntT"] =     { str = "[ Normal ]", highlight = "SLNormal"},
	["v"] =       { str = "[ Visual ]", highlight = "SLVisual"},
	["vs"] =      { str = "[ Visual ]", highlight = "SLVisual"},
	["V"] =       { str = "[ VisLin ]", highlight = "SLVisualLine"},
	["Vs"] =      { str = "[ VisLin ]", highlight = "SLVisualLine"},
	["CTRL_V"] =  { str = "[ VisBlk ]", highlight = "SLVisualBlock"},
	["CTRL_Vs"] = { str = "[ VisBlk ]", highlight = "SLVisualBlock"},
	["s"] =       { str = "--Select--", highlight = "SLSelect"},
	["S"] =       { str = "--Select--", highlight = "SLSelect"},
	["CTRL_S"] =  { str = "--Select--", highlight = "SLSelect"},
	["i"] =       { str = "--Insert--", highlight = "SLInsert"},
	["ic"] =      { str = "--Insert--", highlight = "SLInsert"},
	["ix"] =      { str = "--Insert--", highlight = "SLInsert"},
	["R"] =       { str = "--Replce--", highlight = "SLReplace"},
	["Rc"] =      { str = "--Replce--", highlight = "SLReplace"},
	["Rx"] =      { str = "--Replce--", highlight = "SLReplace"},
	["c"] =       { str = "--Cmmand--", highlight = "SLCommand"},
	["cv"] =      { str = "--Cmmand--", highlight = "SLCommand"},
	["t"] =       { str = "[ Termnl ]", highlight = "SLTerminal"},
	["default"] = { str = "[???]"}, -- hi SLMode guibg=black guifg=white
}

local highlights = {
	["SLBackground"] = {
		bg = "#181818",
	},
	["SLFileType"] = {
		bg = "#ce0406",
		fg = "black",
	},
	["SLBufNumber"] = {
		bg = "SeaGreen",
		fg="#003333",
	},
	["SLLineNumber"] = {
		bg = "#80a0ff",
		fg = "#003366",
	},
	["SLNormal"] = {
		bg = "#571cbd",
		fg = "#c8c093",
	},
	["SLInsert"] = {
		bg = "#7e9cd8",
		fg = "#181818",
	},
	["SLVisual"] = {
		bg = "#76946a",
		fg = "#181818",
	},
	["SLVisualLine"] = {
		bg = "#ad410e",
	},
	["SLVisualBlock"] = {
		bg = "#181818",
		fg = "#80a0ff",
	},
	["SLReplace"] = {
		bg = "#ce0406",
		fg = "#181818",
	},
	["SLCommand"] = {
		fg = "#181818",
		bg = "#ffa066",
	},
	["SLTerminal"] = {
		fg = "#e6c384",
		bg = "#181818",
	},
	["SLSelect"] = {
		link = "SLLineNumber",
	},
	["SLMode"] = {
		link = "SLNormal",
	},
	["SLModified"] = {
		link = "SLFileType",
	},
}

for group, settings in pairs(highlights) do
	vim.api.nvim_set_hl(0, group, settings)
end

function ModeString()
	vim.api.nvim_set_hl(0, "SLMode", {})
	local mode = vim.fn.mode()
	if mode == "R" then
		vim.cmd"redrawstatus!"
	end
	if modes[mode] ~= nil then
		vim.api.nvim_set_hl(0, "SLMode", {
			link = modes[mode]["highlight"]
		})
		return modes[mode]["str"]
	else
		vim.api.nvim_set_hl(0, "SLMode", {
			bg = "black",
			fg = "white"
		})
		return modes["default"]
	end
end

local statusline = "%#SLBackground#"
statusline = string.format("%s%s", statusline, "%#SLMode#")
statusline = string.format("%s%s", statusline, " %{%v:lua.ModeString()%} ")
statusline = string.format("%s%s", statusline, "%#SLBackground#")
statusline = string.format("%s%s", statusline, " %f %m%r")
statusline = string.format("%s%s", statusline, "%=")
statusline = string.format("%s%s", statusline, " %#SLFileType#")
statusline = string.format("%s%s", statusline, " %y")
statusline = string.format("%s%s", statusline, " %#SLLineNumber#")
statusline = string.format("%s%s", statusline, " (%l:%c)")
statusline = string.format("%s%s", statusline, " %#SLBufNumber#")
statusline = string.format("%s%s", statusline, " [%{winnr()}:%n] ")
vim.opt.statusline = statusline

vim.api.nvim_create_autocmd("ColorScheme", {
	once = false,
	group = vim.api.nvim_create_augroup("StatusLine", {}),
	callback = function()
		for group, settings in pairs(highlights) do
			vim.api.nvim_set_hl(0, group, settings)
		end
	end
})
