local Player = require 'Player'
local Freighter = require 'Freighter'
local Timer = require 'hump.timer'

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
local Freighters = {}

local planet, planetW, planetH
local stars = {}

local updateFreighters = false
local dt = love.timer.getDelta()
local elapsedSeconds = 0 -- time since gameStart

player = Player.create()


function love.load()
    player:load()

    planet = love.graphics.newImage("planet.png")
    planetW = planet:getWidth()
    planetH = planet:getHeight()

    --create stars
    for i=1,height,1 do
        stars[i] = { ["x"] = math.random(0, width), ["y"] = i }
    end
    Timer.addPeriodic(3, createFreighters())
end

function love.draw()
    love.graphics.setBackgroundColor(48, 93, 117)

    --draw stars
    for i=1,height,1 do
        love.graphics.point(stars[i].x, stars[i].y)
    end

    -- draw planet
    love.graphics.draw(planet, 100, 50, math.pi*2, 1, 1)
    love.graphics.rectangle("line", 100, 50, planetW, planetH)

    player:draw()

    --draw fighter(s)
    for i,v in ipairs(Freighters) do
        v:draw()
        love.graphics.print(i .. " [" .. v.x .. ", " .. v.y .. "]", v.x, v.y)
    end
end

function love.update()
    player:update()
    for i,v in ipairs(Freighters) do
        v:update()
    end
end

function createFreighters()
    freighter = Freighter.create()
    freighter:load()

    elapsedSeconds = love.timer.getTime()
    --create 5 fighters
    for i=1,5 do
        if tablelength(Freighters) <= 5 then

            freighter = Freighter.create()
            print("#" .. i .. ": diffX = sx - px = " .. freighter.x - 100)
            print("#" .. i .. ": diffY = sy - py = " .. freighter.y - 50)

            freighter.visible = true
            table.insert(Freighters, freighter)
        end
    end
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end