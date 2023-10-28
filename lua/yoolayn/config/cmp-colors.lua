local groups = {
	"CmpItemKindTypeParameter",
	"CmpItemKindConstructor",
	"CmpItemKindEnumMember",
	"CmpItemKindReference",
	"CmpItemKindInterface",
	"CmpItemKindVariable",
	"CmpItemKindProperty",
	"CmpItemKindOperator",
	"CmpItemKindFunction",
	"CmpItemKindConstant",
	"CmpItemKindSnippet",
	"CmpItemKindKeyword",
	"CmpItemKindCopilot",
	"CmpItemKindStruct",
	"CmpItemKindModule",
	"CmpItemKindMethod",
	"CmpItemKindFolder",
	"CmpItemKindValue",
	"CmpItemKindField",
	"CmpItemkindEvent",
	"CmpItemkindColor",
	"CmpItemKindClass",
	"CmpItemkindUnit",
	"CmpItemKindText",
	"CmpItemKindFile",
	"CmpItemKindEnum",
}

local function decoder(decimalColor)
	local red = math.floor((decimalColor / 65536) % 256)
	local green = math.floor((decimalColor / 256) % 256)
	local blue = math.floor(decimalColor % 256)
	local hexColor = string.format("#%02X%02X%02X", red, green, blue)
	return hexColor
end

local function darken(hex, factor)
    local r = tonumber(hex:sub(2, 3), 16)
    local g = tonumber(hex:sub(4, 5), 16)
    local b = tonumber(hex:sub(6, 7), 16)

	r = r * factor
	g = g * factor
	b = b * factor

    return string.format("#%02X%02X%02X", r, g, b)
end

local function encoder(hexColor)
	hexColor = hexColor:gsub("#", "")
	local red = tonumber(hexColor:sub(1, 2), 16)
	local green = tonumber(hexColor:sub(3, 4), 16)
	local blue = tonumber(hexColor:sub(5, 6), 16)

	local decimalColor = (red * 65536) + (green * 256) + blue

	return decimalColor
end

local function get_colors(hl)
	local group = vim.api.nvim_get_hl(0, {name = hl})
	if group["fg"] ~= nil or group["bg"] ~= nil then
		return group
	else
		return get_colors(group["link"])
	end
end

for _, group in ipairs(groups) do
	local original = get_colors(group)
	local hex = decoder(original.fg)
	vim.api.nvim_set_hl(0, group, {
		bg = original.fg,
		fg = encoder(darken(hex, 0.40))
	})
end
