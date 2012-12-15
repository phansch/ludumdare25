local Player = require 'Player'
local Freighter = require 'Freighter'
Timer = require 'hump.timer'

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
local Freighters = {}

local planet, planetW, planetH
local stars = {}

local updateFreighters = false
local dt = love.timer.getDelta()
local handle
player = Player.create()

function love.load()

    player:load()

    planet = love.graphics.newImage("img/planet.png")
    planetW = planet:getWidth()
    planetH = planet:getHeight()

    --create stars
    for i=1,height,1 do
        stars[i] = { ["x"] = math.random(0, width), ["y"] = i }
    end
    Timer.addPeriodic(math.random(1, 20), function() createFreighter() end, 5)
end

function love.draw()
    love.graphics.setBackgroundColor(48, 93, 117)

    --draw stars
    for i=1,height,1 do
        love.graphics.point(stars[i].x, stars[i].y)
    end

    -- draw planet
    love.graphics.draw(planet, 100, 50, math.pi*2, 1, 1)

    player:draw()

    --draw fighter(s)
    for i,v in ipairs(Freighters) do
        v:draw()
        love.graphics.print(i .. " [" .. math.floor(v.x) .. ", " .. math.floor(v.y) .. "]", v.x, v.y)
    end
end

function love.update()
    player:update()
    for i,f in ipairs(Freighters) do
        f:update()
    end
    Timer.update(dt)
end

function createFreighter()
    freighter = Freighter.create()
    freighter:load()
    table.insert(Freighters, freighter)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end