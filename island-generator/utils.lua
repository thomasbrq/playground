local M = {}

function M.hex2rgb(hex)
    hex = hex:gsub("#","")

	return {
		r = tonumber("0x"..hex:sub(1,2)) / 255,
		g = tonumber("0x"..hex:sub(3,4)) / 255,
		b = tonumber("0x"..hex:sub(5,6)) / 255,
		a = 1
	}
end

return M