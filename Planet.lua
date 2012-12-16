local Planet = {width, height}
Planet.__index = Planet

local x, y, rotation = 100, 50, math.pi*2
local planet

function Planet.create()
    local planet = {}
    setmetatable(planet, Planet)
    return planet
end

function Planet:load()
    planet = love.graphics.newImage("img/planet.png")
    self.width = planet:getWidth()
    self.height = planet:getHeight()
end

function Planet:draw()
    love.graphics.draw(planet, x, y, rotation, 2.0, 2.0) -- draw planet
end

return Planet