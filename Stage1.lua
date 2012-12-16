-- show the player how to move, etc, introduce him to the story
-- not in the final system, yet, needs more particle effects

Gamestate.stage1 = Gamestate.new()
local state = Gamestate.stage1

local Player = require 'Player'
local Stars = require 'Stars'
local Conversation = require 'Conversation'

local player = Player.create()
local stars = Stars.create()

local text = "Hail pilot, apparently the coordinated we sent to you, were off by a few lightyears.\n"
            .."According to our sensors, there's nothing but space dust around you \n"
            .."It will take a few moments until the new calculation is done.\n"
            .."You might want to use the time to get familiar with the controls of your ship.\n"
            .."\n\n Use w/a/s/d or the arrow keys to control your ship and space to fire."

local conversation = Conversation.create("Incoming transmission ...", text, "Wait for coordinates (Press enter)")

local drawUI = false

function state:init()
    stars:load()
    conversation:load()
    player:load()

    --draw dialogue after a few seconds
    Timer.add(5, function() drawUI = true end)
end

function state:update(dt)
    if not drawUI then
        player:update(dt)
    end
end

function state:draw()
    stars:draw()
    player:draw()

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

        --switch to next gamestate in a few
        Timer.add(5, function() Gamestate.switch(Gamestate.stage2) end)
    end
    if key == ' ' and not drawUI then
        player:fireConstantly()
    end
end