-- This is the most convoluted code I've written so far.
-- I'm new to lua, so there's an excuse
local Player = require 'Player'
local Freighter = require 'Freighter'
local Timer = require 'hump.timer'

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
local Freighters = {}

local planet, planetW, planetH
local stars = {}

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

    --add freighters
    Timer.addPeriodic(math.random(1, 20), function() createFreighter() end, 5)
end

function love.draw()
    love.graphics.setBackgroundColor(48, 93, 117)

    --draw stars
    for i=1,height,1 do
        love.graphics.point(stars[i].x, stars[i].y)
    end

    love.graphics.draw(planet, 100, 50, math.pi*2, 1, 1) -- draw planet

    player:draw()

    --draw freighter(s)
    for i,v in ipairs(Freighters) do
        v:draw()
        love.graphics.print(i .. " [" .. math.floor(v.x) .. ", " .. math.floor(v.y) .. "]", v.x, v.y)
    end
end

function love.update()
    player:update()

    for i,freighter in ipairs(Freighters) do
        freighter:update()
        for j,shot in ipairs(player.Shots) do
            if shot:checkCollision(freighter) then
                freighter.visible = false
                killFreighter(i)
                player:removeShot(j)
            end
        end
    end

    Timer.update(dt)
end

function createFreighter()
    freighter = Freighter.create()
    freighter:load()
    table.insert(Freighters, freighter)
end

function killFreighter(freighter)
    table.remove(Freighters, freighter)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end