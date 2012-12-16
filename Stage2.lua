-- The main part of the game
-- The worst code I've written

Gamestate.stage2 = Gamestate.new()
local state = Gamestate.stage2

Player = require 'Player'
Stars = require 'Stars'
local Planet = require 'Planet'
local Freighter = require 'Freighter'
local BigShip = require 'BigShip'
local Conversation = require 'Conversation'
local PSystems = require 'ParticleSystems'

player = Player.create()
stars = Stars.create()
local planet = Planet.create()
local bigShip = BigShip.create()
local psystems = PSystems.create()

local conversation = Conversation.create(conv_stage2_1_title,
                                        conv_stage2_1_text,
                                        conv_stage2_1_confirm)

local conversation2 = Conversation.create(conv_stage2_2_title,
                                        conv_stage2_2_text,
                                        conv_stage2_2_confirm)


local maxKills = 5 --this is when the game ends
local conv2triggerKills = 2 -- when the 2nd conversation appears

local Freighters = {}
local freighterCount, killCount = 0, 0
local drawUI, drawUI2 = true, false

function state:init()
    Timer.clear()
    player:load()
    stars:load()
    conversation:load()
    conversation2:load()
    bigShip:load()
    planet:load()

    --add freighters
    freighterCount = 0

    psystems:initFTLJump()
    psystems:initExplosion()
end

function state:update(dt)
    if not drawUI and not drawUI2 then
        player:update(dt)
        jumpRechargeBar:update(dt)
    end

    if killCount ~= conv2triggerKills and not drawUI2 then
        self:updateFreighterStatus(dt)
    end

    if freighterCount < 4 and killCount < maxKills and not drawUI2 then
        local randomAdd = math.random(3, 5)
        -- add between 3 and 5 freighters
        Timer.addPeriodic(1.5, function() self:createFreighter() end, randomAdd)
        freighterCount = freighterCount + randomAdd
    end

    psystems:update(dt)
end

function state:draw()
    stars:draw()
    planet:draw()

    --only draw these AFTER entering the system
    if not drawUI then
        player:draw()
        jumpRechargeBar:draw()
    end

    --draw freighter(s)
    for i,v in ipairs(Freighters) do
        v:draw()
    end

    if drawUI then
        love.graphics.setColor(0, 0, 0, 100)
        love.graphics.rectangle("fill", 0, 0, width, height)
        love.graphics.setColor(255, 255, 255, 255)
        conversation:draw()
    end

    if drawUI2 then
        love.graphics.setColor(0, 0, 0, 100)
        love.graphics.rectangle("fill", 0, 0, width, height)
        love.graphics.setColor(255, 255, 255, 255)
        conversation:draw()

        player:draw()
    end

    if killCount == conv2triggerKills then
        drawUI2 = true

        killCount = killCount + 1
    end
    if killCount > maxKills and freighterCount == 0 then
        Gamestate.switch(Gamestate.stage3)
    end

    psystems:draw()
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
    if key == 'return' and drawUI then --when UI is confirmed

        player:stopFire() --stop firing after UI is hidden


        -- only play jump animation when just arrived in system
        if killCount == 0 and drawUI then
            drawUI = false
            self:FTLJump(player.x, player.y)
        end

        --to hide the second conversation
        if killCount > 0 and drawUI2 then
            drawUI2 = false
        end
    end
    if key == ' ' and not drawUI then
        player:fireConstantly()
    end
end

function state:updateFreighterStatus(dt)
    for i,freighter in ipairs(Freighters) do
        freighter:update(dt)
        for j,shot in ipairs(player.Shots) do

            if shot:checkCollision(freighter) then

                if(freighter.hp > 1) then
                    self:hit() --play sfx
                    player:removeShot(j)
                    freighter.hp = freighter.hp - 1
                else
                    self:explode(freighter.x, freighter.y) -- play sfx and animation

                    freighter.visible = false
                    self:killFreighter(i)
                    player:removeShot(j)
                end
            end
        end
    end
end

function state:createFreighter()
    freighter = Freighter.create()
    freighter:load()
    self:FTLJump(freighter.x, freighter.y) -- play jump animation and sfx
    table.insert(Freighters, freighter)
end

function state:killFreighter(freighter)
    table.remove(Freighters, freighter)
    freighterCount = freighterCount - 1
    killCount = killCount + 1
end

---------------------------
-- Audio and particle systems
---------------------------
function state:FTLJump(x, y)
    psystems[1]:setPosition(x, y)
    psystems[1]:start()

    love.audio.play(sfx_ftl)
    love.audio.rewind(sfx_ftl)
end

function state:explode(x, y)
    psystems[2]:setPosition(x, y)
    psystems[2]:start()

    love.audio.setVolume(0.1)
    love.audio.play(sfx_freighter_explosion)
    love.audio.rewind(sfx_freighter_explosion)
    love.audio.setVolume(1.0)
end

function state:hit()
    love.audio.setVolume(0.1)
    love.audio.play(sfx_freighter_hit)
    love.audio.rewind(sfx_freighter_hit)
    love.audio.setVolume(1.0)
end