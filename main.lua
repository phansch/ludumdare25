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
    love.graphics.setBackgroundColor(48, 93, 117)

    --draw stars
    for i=1,height,1 do
        love.graphics.point(stars[i].x, stars[i].y)
    end

    -- draw planet
    love.graphics.draw(planet, 200, 150, math.pi*2, 1, 1, planetW/2, planetH/2)

    player:draw()
end

function love.update()
    player:update()
end