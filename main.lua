-- This is the most convoluted code I've written so far.
-- I'm new to lua, so there's an excuse
Timer = require 'hump.timer'
Gamestate = require "hump.gamestate"
gameData = require 'GameData' -- some globals

local menu = require 'Menu' -- menu gamestate
local stage1 = require 'Stage1'
local stage2 = require 'Stage2'
local stage3 = require 'Stage3'
local credits = require 'Credits'

function love.load()
    love.graphics.setFont(font)
    Gamestate.registerEvents()
    Gamestate.switch(Gamestate.stage1)
end

function love.update(dt)

    Timer.update(dt)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end