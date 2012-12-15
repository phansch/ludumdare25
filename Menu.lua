Gamestate.menu = Gamestate.new()
local state = Gamestate.menu

function state:init()

end

function state:update(dt)

end

function state:draw()
    love.graphics.print("Press space to play.", 100, 200)
end

function state:keypressed(key)
    if key == ' ' then
        Gamestate.switch(Gamestate.game)
    end
end


