-- show the player how to move, etc, introduce him to the story
-- not in the final system, yet, needs more particle effects

Gamestate.stage2 = Gamestate.new()
local state = Gamestate.stage2

local Player = require 'Player'
local Stars = require 'Stars'
local Planet = require 'Planet'
local Freighter = require 'Freighter'
local Conversation = require 'Conversation'

local player = Player.create()
local stars = Stars.create()
local planet = Planet.create()
local conversation = Conversation.create("hello there", "we are picking up signals of bla bla", "Press enter")

local Freighters = {}
local particleSystems = {}

local drawUI = true

function state:init()
    Timer.clear()
    player:load()
    stars:load()
    conversation.load()
    planet:load()

    -- init particle systems
    self:initExplosionPS()
    self:initFTLJumpPS()

    --add 5 fighters
    Timer.addPeriodic(1, function() self:createFreighter() end, 10)

    -- audio
    sfx_freighter_hit = love.audio.newSource("audio/hit3.wav", "static")
    sfx_freighter_explosion = love.audio.newSource("audio/explosion2.wav", "static")
    sfx_ftl = love.audio.newSource("audio/ftl.wav", "static")
end

function state:update(dt)
    if not drawUI then
        player:update(dt)
    end

    self:updateFreighterStatus()

    particleSystems[1]:update(dt)
    particleSystems[2]:update(dt)
end

function state:draw()
    stars:draw()
    planet:draw()

    if not drawUI then
        player:draw()
    end

    --draw freighter(s)
    for i,v in ipairs(Freighters) do
        v:draw()
    end

    --draw explosions
    love.graphics.setBlendMode("additive")
    love.graphics.draw(particleSystems[1], 0, 0)
    love.graphics.draw(particleSystems[2], 0, 0)
    love.graphics.setBlendMode("alpha")

    if drawUI then
        love.graphics.setColor(0, 0, 0, 100)
        love.graphics.rectangle("fill", 0, 0, width, height)
        love.graphics.setColor(255, 255, 255, 255)
        conversation:draw()
    end
end

function state:keyreleased(key)
    if key == ' ' and not drawUI then
        player:fireSingle()
        player:stopFire()
    end
    if key == 'up' or key == 'w' then
        --if keys are released, slow the ship down
        player:doSlowdown()
    end
end

function state:keypressed(key)
    if key == 'return' then --when UI is confirmed
        drawUI = false
        --Timer.add(40, function() Gamestate.switch(stage2) end)
    end
    if key == ' ' and not drawUI then
        player:fireConstantly()
    end
end

function state:updateFreighterStatus()
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
                    self:killFreighter(i)
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
end

function state:createFreighter()
    freighter = Freighter.create()
    freighter:load()

    particleSystems[2]:setPosition(freighter.x, freighter.y)
    particleSystems[2]:start()

    love.audio.play(sfx_ftl)
    love.audio.rewind(sfx_ftl)

    table.insert(Freighters, freighter)
end

function state:killFreighter(freighter)
    table.remove(Freighters, freighter)
end

function state:initExplosionPS()
    local particle_explosion = love.graphics.newImage("img/particle_explosion.png")
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

function state:initFTLJumpPS()
    local particle_jump = love.graphics.newImage("img/particle_explosion.png")
    local p = love.graphics.newParticleSystem(particle_jump, 1000)
    p:setEmissionRate(500)
    p:setSpeed(160, 600)
    p:setSizes(3, 1)
    --old values  p:setColors(220, 105, 20, 255, 194, 30, 18, 0)
    p:setColors(220, 205, 240, 100, 194, 30, 18, 0)
    p:setLifetime(0.2)
    p:setParticleLife(0.3)
    p:setDirection(0)
    p:setSpread(360)
    p:setTangentialAcceleration(310)
    p:setRadialAcceleration(500)
    p:stop()
    table.insert(particleSystems, p)
end