local Player = require 'Player'
--local Freighter = require 'Freighter'

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
--local Freighters = {}

local planet, planetW, planetH
local stars = {}

player = Player.create()
--freighter = Freighter.create()

function love.load()
    player:load()

    planet = love.graphics.newImage("planet.png")
    planetW = planet:getWidth()
    planetH = planet:getHeight()

    --create stars
    for i=1,height,1 do
        stars[i] = { ["x"] = math.random(0, width), ["y"] = i }
    end
    -- init N freighters
    -- always have >= 5 freighters on the field
    -- have them move in from the edges, to the planet
    -- healthbar
end

function love.draw()
    --draw stars
    for i=1,height,1 do
        --random size
        love.graphics.point(stars[i].x, stars[i].y)
    end

    -- draw planet
    love.graphics.draw(planet, 200, 150, math.pi*2, 1, 1, planetW/2, planetH/2)

    player:draw()
end

function love.update()
    player:update()
end