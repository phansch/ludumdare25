local Shot = require 'Shot'
local Timer = require 'hump.timer'

local BigShip = {x, y, Shots = {}, rotation, speed, slowdown, destX, destY, imgWidth, imgHeight }
BigShip.__index = BigShip

local img
local shotTimer = Timer.new()

function BigShip.create()
    local bigShip = {}
    setmetatable(bigShip, BigShip)
    bigShip.x = math.random(50, width-50)
    bigShip.y = math.random(height-100, height+50)
    bigShip.rotation = 0
    bigShip.visible = true
    bigShip.speed = 3
    bigShip.slowdown = false
    --set random destination around planet
    bigShip.destX = math.random(100,355)
    bigShip.destY = math.random(50,305)
    return bigShip
end

function BigShip:load()
    img = love.graphics.newImage("img/human_imperial_ship.png")
    self.imgWidth = img:getWidth()
    self.imgHeight = img:getHeight()
end

function BigShip:update(dt)
    local rotateTo = math.atan2(self.x - self.destX, self.y - self.destY)

    if (rotateTo > self.rotation + math.pi/2) then rotateTo = rotateTo + math.pi*2 end
    if (rotateTo < self.rotation - math.pi/2) then rotateTo = rotateTo + math.pi*2 end

    self.rotation = rotateTo

    self:updateLocation(dt)
end

function BigShip:draw()
    if self.visible then
        love.graphics.draw(img, self.x, self.y, self.rotation, 3, 3, self.imgWidth/2, self.imgHeight/2)
    end
end

function BigShip:fire(x, y)
    love.graphics.line(self.x, self.y, x, y)
    self:createShots()
end

function BigShip:updateLocation(dt)
    local moveX = (self.destX - self.x) / self.speed * dt
    local moveY = (self.destY - self.y) / self.speed * dt
    if self:isInBounds(moveX, moveY) then
        self.x = self.x + moveX
        self.y = self.y + moveY
    end
end

function BigShip:isInBounds(moveX, moveY)
    return (self.x + moveX > 0) and (self.y + moveY > 0) and (self.x + moveX < width+50) and (self.y + moveY < height+50)
end

function BigShip:createShots()
    local shotOffsetX, shotOffsetY = 7, 7
    if (self.rotation > math.pi/2 and self.rotation < math.pi) or (self.rotation > math.pi*1.5 and self.rotation < math.pi*2) then
        shotOffsetY = shotOffsetY * -1
    end

    local shot = Shot.create(self.x+shotOffsetX, self.y+shotOffsetY, self.rotation)
    shot:load()
    table.insert(self.Shots, shot)
    shot = Shot.create(self.x-shotOffsetX, self.y-shotOffsetY, self.rotation)
    shot:load()
    table.insert(self.Shots, shot)
end

return BigShip