Gamestate.conversation = Gamestate.new()
local state = Gamestate.conversation

local backdrop, title, text
function state:init()
    backdrop = love.graphics.newImage("img/dialogue_backdrop.png")

    title = "Incoming order ..."
    text = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
    -- I am a terrible writer D:
    closeText = "Accept your mission (Press return)"
end

function state:update(dt)
    -- fade in/out to bottom
    self:fadeIn()
end

function state:draw()

    love.graphics.setColor(255, 255, 255, 0)
    love.graphics.setColorMode("combine")
    x = width/2-backdrop:getWidth()/2*0.8
    y = height - backdrop:getHeight()
    love.graphics.draw(backdrop, x, y, math.rad(0), 0.8, 0.8)

    love.graphics.setNewFont(24)
    love.graphics.print(title, x+30, y+25)
    love.graphics.setNewFont(14)
    love.graphics.printf(text, x+60, y+60, 570)

    love.graphics.setNewFont(16)
    love.graphics.printf(closeText, x+350, y+200, 570)
end

function state:fadeIn()

end

function state:keypressed(key)
    if key == ' ' then
        Gamestate.switch(Gamestate.game)
    end
end


