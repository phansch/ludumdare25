Gamestate.game = Gamestate.new()
local state = Gamestate.game

local Player = require 'Player'
local Freighter = require 'Freighter'

width = love.graphics.getWidth()
height = love.graphics.getHeight()

local Freighters = {}

local planet, planetW, planetH
local stars = {}

local dt = love.timer.getDelta()
local player = Player.create()
local particleSystems = {}

function state:init()
    --add freighters
    --Timer.addPeriodic(0.1, function() createFreighter() end, 5)
    for i=1,5 do
        createFreighter()
    end

    player:load()

    planet = love.graphics.newImage("img/planet.png")
    planetW = planet:getWidth()
    planetH = planet:getHeight()

    --create stars
    for i=1,height,1 do
        stars[i] = { ["x"] = math.random(0, width), ["y"] = i }
    end

    initParticleSystem()

    -- audio
    music_background = love.audio.newSource("audio/Leviathan.mp3")
    sfx_freighter_hit = love.audio.newSource("audio/hit3.wav", "static")
    sfx_freighter_explosion = love.audio.newSource("audio/explosion2.wav", "static")
    love.audio.play(music_background)
end

function state:load()

end

function state:update()
    player:update()

    for i,freighter in ipairs(Freighters) do
        freighter:update()
        for j,shot in ipairs(player.Shots) do

            if shot:checkCollision(freighter) then

                if(freighter.hp > 1) then
                    love.audio.play(sfx_freighter_hit)
                    love.audio.rewind(sfx_freighter_hit)
                    player:removeShot(j)
                    freighter.hp = freighter.hp - 1

                else
                    freighter.visible = false
                    killFreighter(i)
                    player:removeShot(j)
                    particleSystems[1]:setPosition(freighter.x, freighter.y)
                    particleSystems[1]:start()
                    love.audio.play(sfx_freighter_explosion)
                    love.audio.rewind(sfx_freighter_explosion)
                end
                break
            end
        end
    end

    particleSystems[1]:update(dt)
end

function state:draw()
    love.graphics.setBackgroundColor(0, 0, 0)

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

    love.graphics.setBlendMode("additive")
    love.graphics.draw(particleSystems[1], 0, 0)
    love.graphics.setBlendMode("alpha")
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

function initParticleSystem()
    particle_explosion = love.graphics.newImage("img/particle_explosion.png")
    local p = love.graphics.newParticleSystem(particle_explosion, 1000)
    p:setEmissionRate(1000)
    p:setSpeed(300, 400)
    p:setSizes(3, 1)
    p:setColors(220, 105, 20, 255, 194, 30, 18, 0)
    p:setLifetime(0.1)
    p:setParticleLife(0.2)
    p:setDirection(0)
    p:setSpread(360)
    p:setTangentialAcceleration(10)
    p:setRadialAcceleration(500)
    p:stop()
    table.insert(particleSystems, p)
end