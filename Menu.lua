Gamestate.menu = Gamestate.new()
local state = Gamestate.menu

function state:init()
    music_background = love.audio.newSource("audio/Orbiting.mp3")
    love.audio.play(music_background)
end

function state:update(dt)

end

function state:draw()
    love.graphics.print("Press enter to play.", 100, 200)
end

function state:keypressed(key)
    if key == 'return' then
        --love.audio.stop(music_background)
        Gamestate.switch(Gamestate.stage1)
    end
end


