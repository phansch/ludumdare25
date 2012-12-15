local vector = require 'hump.vector'
local Freighter = {x, y, visible, rotation, speed, slowdown, destX, destY }
Freighter.__index = Freighter

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
local img, imgWidth, imgHeight

local dt = love.timer.getDelta()

function Freighter.create()
    local freighter = {}
    setmetatable(freighter, Freighter)
    freighter.x = math.random(50, width-50)
    freighter.y = math.random(height-100, height+50)
    freighter.rotation = math.sin(freighter.x-100 / freighter.y-50)
    freighter.visible = true
    freighter.speed = 80
    freighter.slowdown = false
    --set random destintion around planet
    freighter.destX = math.random(100,355)
    freighter.destY = math.random(50,305)
    return freighter
end

function Freighter:load()
    img = love.graphics.newImage("freighter.png")
    imgWidth = img:getWidth()
    imgHeight = img:getHeight()

end

function Freighter:draw()
    if self.visible then
        love.graphics.draw(img, self.x, self.y, self.rotation, 2, 2, imgWidth/2, imgHeight/2)
    end
end

function Freighter:update()
    --move to 100, 150
    self.rotation = math.cos(self.x / self.y)
    print(self.rotation)
    --math.rad: degree -> radian

    self:updateLocation()
    -- TODO: add move code
end

function Freighter:slowdown(ultimate)
    if self.slowdown == true then
        self.speed = self.speed - 1.5
        self:updateLocation()
        if self.speed <= 0 then
            self.speed = 20
            self.slowdown = false
        end
    end
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