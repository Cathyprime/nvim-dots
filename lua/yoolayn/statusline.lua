local modes = {
	["n"] = "[ Normal ]",
	["niI"] = "[ Normal ]",
	["niR"] = "[ Normal ]",
	["niV"] = "[ Normal ]",
	["nt"] = "[ Normal ]",
	["ntT"] = "[ Normal ]",
	["v"] = "[ Visual ]",
	["vs"] = "[ Visual ]",
	["V"] = "[ VisLin ]",
	["Vs"] = "[ VisLin ]",
	["CTRL_V"] = "[ VisBlk ]",
	["CTRL_Vs"] = "[ VisBlk ]",
	["s"] = "--Select--",
	["S"] = "--Select--",
	["CTRL_S"] = "--Select--",
	["i"] = "--Insert--",
	["ic"] = "--Insert--",
	["ix"] = "--Insert--",
	["R"] = "--Replce--",
	["Rc"] = "--Replce--",
	["Rx"] = "--Replce--",
	["c"] = "--Cmmand--",
	["cv"] = "--Cmmand--",
	["t"] = "[ Termnl ]",
	["default"] = "[???]", -- hi SLMode guibg=black guifg=white
}

local M = {}

function M.ModeString()
	local mode = vim.fn.mode()
	if modes[mode] ~= nil then
		return modes[mode]
	else
		return modes["default"]
	end
end

return M
