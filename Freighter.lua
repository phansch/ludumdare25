local vector = require 'hump.vector'
local Freighter = {x, y, visible}
Freighter.__index = Freighter

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

local angle, speed = 0, 5
local img, imgWidth, imgHeight

local dt = love.timer.getDelta()
local slowdown = false

function Freighter.create(x, y)
    local freighter = {}
    setmetatable(freighter, Freighter)
    freighter.x = math.random(50, width-50)
    freighter.y = math.random(50, height-50)
    return freighter
end

function Freighter:load()
    img = love.graphics.newImage("freighter.png")
    imgWidth = img:getWidth()
    imgHeight = img:getHeight()
end

function Freighter:draw()
    if self.visible then
        angle = math.asin((self.y / self.x) * math.sin(90))
        love.graphics.draw(img, self.x, self.y, angle, 2, 2, imgWidth/2, imgHeight/2)
    end
end

function Freighter:update()
    --move to 100, 150

    self:updateLocation()
    -- TODO: add move code
end

function Freighter:slowdown(ultimate)
    if slowdown == true then
        speed = speed - 1.5
        self:updateLocation()
        if speed <= 0 then
            speed = 20
            slowdown = false
        end
    end
end

function Freighter:updateLocation()
    local degrees = math.asin((self.x / self.y) * math.sin(90))
    print(degrees)
    local moveX = math.cos(degrees * math.pi / 180) * speed * dt
    local moveY = math.sin(degrees * math.pi / 180) * speed * dt
    if self:isInBounds(moveX, moveY) then
        self.x = self.x + moveX
        self.y = self.y + moveY
    end
end

function Freighter:isInBounds(moveX, moveY)
    return (self.x + moveX > 0) and (self.y + moveY > 0) and (self.x + moveX < width) and (self.y + moveY < height)
end

return Freighter