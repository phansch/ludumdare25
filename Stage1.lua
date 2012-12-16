-- show the player how to move, etc, introduce him to the story
-- not in the final system, yet, needs more particle effects

Gamestate.stage1 = Gamestate.new()
local state = Gamestate.stage1

local Player = require 'Player'
local Stars = require 'Stars'
local Conversation = require 'Conversation'
local PSystems = require 'ParticleSystems'

local player = Player.create()
local stars = Stars.create()
local psystems = PSystems.create()

local conversation = Conversation.create(conv_stage1_1_title,
                                        conv_stage1_1_text,
                                        conv_stage1_1_confirm)

local drawUI = false
local drawPlayer = false

function state:init()
    stars:load()
    conversation:load()
    player:load()
    psystems:initFTLJump()

    Timer.add(2, function()
        self:FTLJump(player.x, player.y)
        drawPlayer = true

        --draw dialogue after a few seconds
        Timer.add(5, function() drawUI = true end)
    end)
end

function state:update(dt)
    if not drawUI then
        player:update(dt)
    end

    psystems:update(dt)
end

function state:draw()
    stars:draw()

    if drawPlayer then
        player:draw()
    end

    psystems:draw()

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
    if key == 'return' then -- when dialogue is confirmed
        drawUI = false
        player:stopFire()

        --switch to next gamestate in a few
        Timer.add(5, function()
            self:FTLJump() -- play jump animation

            --stop drawing the player after jump animation
            Timer.add(0.2, function() drawPlayer = false end)

            -- wait another 5 seconds to switch to stage2
            Timer.add(5, function()
                Gamestate.switch(Gamestate.stage2)
            end)
        end)


    end
    if key == ' ' and not drawUI then
        player:fireConstantly()
    end
end

function state:FTLJump(x, y)
    psystems[1]:setPosition(player.x, player.y)
    psystems[1]:start()

    love.audio.play(sfx_ftl)
    love.audio.rewind(sfx_ftl)
end