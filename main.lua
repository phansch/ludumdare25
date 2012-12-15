-- This is the most convoluted code I've written so far.
-- I'm new to lua, so there's an excuse
Timer = require 'hump.timer'
Gamestate = require "hump.gamestate"

local menu = require 'Menu' -- menu gamestate
local game = require 'Game' -- game gamestate
local conversation = require 'Conversation' -- conversation gamestate

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(Gamestate.conversation)
end

function love.update(dt)
    Timer.update(dt)
end