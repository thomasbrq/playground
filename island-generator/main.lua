---@diagnostic disable: lowercase-global

perlin = require("perlin")
utils = require("utils")

local GRID_SIZE = 8
local RADIUS = 50

local grid = {}

function create_radial_gradient()
	local g = {}

	local cX = 800/GRID_SIZE/2
	local cY = 600/GRID_SIZE/2

	for y = 1, 600/GRID_SIZE, 1 do
		g[y] = {}
		for x = 1, 800/GRID_SIZE, 1 do
			local d = math.sqrt((x-cX)^2 + (y-cY)^2)
			g[y][x] = 1 - d / RADIUS
		end
	end

	return g
end

function mask(noise, gradient)
	for y = 1, 600/GRID_SIZE, 1 do
		for x = 1, 800/GRID_SIZE, 1 do
			noise[y][x] = noise[y][x] * gradient[y][x]
		end
	end
	return noise
end

local function generate_heightmap()
	local baseX = 10000 * love.math.random()
	local baseY = 10000 * love.math.random()
	for y = 1, 600 do
		grid[y] = {}
		for x = 1, 800 do
			grid[y][x] = perlin.noise(baseX+.1*x, baseY+.2*y)
		end
	end

	local radial_gradient	= create_radial_gradient()
	grid 					= mask(grid, radial_gradient)
end

function love.load()
	generate_heightmap()
end

function love.keypressed(key)
	if key == "r" then
		generate_heightmap()
	end
end

local colors = {
	["snow"]		= utils.hex2rgb("#ffffff"),
	["mountain"]	= utils.hex2rgb("#adadad"),
	["mountain2"]	= utils.hex2rgb("#919191"),
	["grass"]		= utils.hex2rgb("#02631c"),
	["grass2"]		= utils.hex2rgb("#017d22"),
	["grass3"]		= utils.hex2rgb("#169c39"),
	["sand"]		= utils.hex2rgb("#fff719"),
	["water"]		= utils.hex2rgb("#2ebae8"),
	["water2"]		= utils.hex2rgb("#1a94bd"),
}

function love.draw()
	local tileSize = GRID_SIZE
	for y = 1, #grid do
		for x = 1, #grid[y] do
			c = grid[y][x]

			if c > .6 then love.graphics.setColor(colors.snow.r, colors.snow.g, colors.snow.b, colors.snow.a)
			else if c > .5 then love.graphics.setColor(colors.mountain.r, colors.mountain.g, colors.mountain.b, colors.mountain.a)
			else if c > .4 then love.graphics.setColor(colors.mountain2.r, colors.mountain2.g, colors.mountain2.b, colors.mountain2.a)
			else if c > .35 then love.graphics.setColor(colors.grass.r, colors.grass.g, colors.grass.b, colors.grass.a)
			else if c > .3 then love.graphics.setColor(colors.grass2.r, colors.grass2.g, colors.grass2.b, colors.grass2.a)
			else if c > .2 then love.graphics.setColor(colors.grass3.r, colors.grass3.g, colors.grass3.b, colors.grass3.a)
			else if c > .16 then love.graphics.setColor(colors.sand.r, colors.sand.g, colors.sand.b, colors.sand.a)
			else if c > .14 then love.graphics.setColor(colors.water.r, colors.water.g, colors.water.b, colors.water.a)
			else love.graphics.setColor(colors.water2.r, colors.water2.g, colors.water2.b, colors.water2.a)
			end end end end end end end end

			love.graphics.rectangle("fill", x*tileSize, y*tileSize, tileSize,  tileSize)
		end
	end
end