local Conversation = { title, text, closeText, playedSound = false }
Conversation.__index = Conversation

local backdrop, decal

function Conversation.create(title, text, closeText)
    local conv = {}
    setmetatable(conv, Conversation)
    conv.title = title
    conv.text = text
    conv.closeText = closeText
    return conv
end

function Conversation:load()
    backdrop = love.graphics.newImage("img/dialogue_backdrop.png")
    decal = love.graphics.newImage("img/decal_green.png")
end

function Conversation:draw()
    if not self.playedSound then
        love.audio.play(sfx_conversation)
        love.audio.rewind(sfx_conversation)
        self.playedSound = true
    end
    local oldColorMode = love.graphics.getColorMode()

    love.graphics.setColorMode("combine")

    x = width/2-backdrop:getWidth()/2*0.8
    y = height - backdrop:getHeight()
    love.graphics.draw(backdrop, x, y, math.rad(0), 0.8, 0.8)


    love.graphics.setFont(font, 24)
    love.graphics.print(self.title, x+30, y+25)
    love.graphics.setFont(font, 14)
    love.graphics.printf(self.text, x+60, y+60, 570)

    love.graphics.setFont(font, 16)
    love.graphics.printf(self.closeText, x+350, y+200, 570)

    love.graphics.setColorMode(oldColorMode)
    --draw decal
    love.graphics.draw(decal, x-10, y-10, math.rad(0), 0.1, 0.1)
    love.graphics.setFont(font, 12)
end

return Conversation