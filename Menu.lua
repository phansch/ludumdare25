Gamestate.menu = Gamestate.new()
local state = Gamestate.menu

function state:init()
    love.audio.play(music_background)
end

function state:update(dt)
    --button eventually
end

function state:draw()
    love.graphics.print("Press enter to play.", 100, 200)
end

function state:keypressed(key)
    if key == 'return' then
        Gamestate.switch(Gamestate.stage1)
    end
end


