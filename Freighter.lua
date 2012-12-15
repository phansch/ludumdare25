local vector = require 'hump.vector'
local Freighter = {x, y, visible, rotation, speed, slowdown, destX, destY, imgWidth, imgHeight, hp }
Freighter.__index = Freighter

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
local img

local dt = love.timer.getDelta()

function Freighter.create()
    local freighter = {}
    setmetatable(freighter, Freighter)
    freighter.x = math.random(50, width-50)
    freighter.y = math.random(height-100, height+50)
    freighter.rotation = 0
    freighter.visible = true
    freighter.speed = 50
    freighter.slowdown = false
    --set random destination around planet
    freighter.destX = math.random(100,355)
    freighter.destY = math.random(50,305)
    freighter.hp = 7
    return freighter
end

function Freighter:load()
    img = love.graphics.newImage("img/freighter.png")
    self.imgWidth = img:getWidth()
    self.imgHeight = img:getHeight()
end

function Freighter:draw()
    if self.visible then
        love.graphics.draw(img, self.x, self.y, self.rotation, 2, 2, self.imgWidth/2, self.imgHeight/2)
    end
end

function Freighter:update()
    local rotateTo = math.atan2(self.x - self.destX, self.y - self.destY)

    if (rotateTo > self.rotation + math.pi/2) then rotateTo = rotateTo + math.pi*2 end
    if (rotateTo < self.rotation - math.pi/2) then rotateTo = rotateTo + math.pi*2 end

    self.rotation = rotateTo

    self:updateLocation()
end

function Freighter:updateLocation()
    local moveX = (self.destX - self.x) / self.speed * dt
    local moveY = (self.destY - self.y) / self.speed * dt
    if self:isInBounds(moveX, moveY) then
        self.x = self.x + moveX
        self.y = self.y + moveY
    end
end

function Freighter:isInBounds(moveX, moveY)
    return (self.x + moveX > 0) and (self.y + moveY > 0) and (self.x + moveX < width+50) and (self.y + moveY < height+50)
end

return Freighter