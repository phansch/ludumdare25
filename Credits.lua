Gamestate.credits = Gamestate.new()
local state = Gamestate.credits

function state:init()

end

function state:draw()
    --TODO: get from textfile maybe
    love.graphics.printf("credits_line1", width/2, height/2, 125, "left")
    love.graphics.print("credits_line2", width/2-100, height/4+40)
    love.graphics.print("credits_line3", width/2-100, height/4+80)

    love.graphics.print(credits_bottom, 20, height-20)
end

function state:keypressed(key)
    if key == 'return' then
        Gamestate.switch(Gamestate.menu)
    end
end