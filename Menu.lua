Gamestate.menu = Gamestate.new()
local state = Gamestate.menu

local Stars = require 'Stars'
local stars = Stars.create()
function state:init()
    love.audio.play(music_background)
    stars:load()
end

function state:update(dt)
    --button eventually
end

function state:draw()
    stars:draw()
    love.graphics.print(menu_instr_center, width/2-100, height/2)
    love.graphics.print(menu_instr_bottom, width/2-200, height-20)
    love.graphics.setColor(255, 0, 0)
    love.graphics.printf(menu_story_title, width/2-80, height/5-40, 500)
    love.graphics.printf(menu_story, width/2-300, height/5, width/2)
    love.graphics.setColor(255, 255, 255)
end

function state:keypressed(key)
    if key == 'return' then
        Gamestate.switch(Gamestate.stage1)
    end
end