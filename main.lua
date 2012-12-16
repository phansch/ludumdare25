-- This is the most convoluted code I've written so far.
-- I'm new to lua, so there's an excuse
Timer = require 'hump.timer'
Gamestate = require "hump.gamestate"

local menu = require 'Menu' -- menu gamestate
local stage1 = require 'Stage1'
local stage2 = require 'Stage2'
--local stage3 = require 'Stage3'
game = require 'Game' -- some globals

function love.load()
    love.graphics.setFont(font)
    Gamestate.registerEvents()
    Gamestate.switch(Gamestate.menu)
end

function love.update(dt)
    Timer.update(dt)
end