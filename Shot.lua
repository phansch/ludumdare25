local Shot = {x, y, rotation}
Shot.__index = Shot

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
local shotImg
local speed = 10
local dt = love.timer.getDelta()

local initialShipRotation = math.pi * 1.5

function Shot.create(x, y, rotation)
    local shot = {}
    setmetatable(shot, Shot)
    shot.x = x
    shot.y = y
    shot.rotation = rotation
    return shot
end

function Shot:load()
    shotImg = love.graphics.newImage("img/laserGreen.png")
    imgWidth = shotImg:getWidth()
    imgHeight = shotImg:getHeight()
end

function Shot:draw()
    love.graphics.draw(shotImg, self.x, self.y, self.rotation, 0.5, 0.5, imgWidth/2, imgHeight/2)
end

function Shot:update()
    local moveX = math.cos(self.rotation + initialShipRotation) * speed * dt
    local moveY = math.sin(self.rotation + initialShipRotation) * speed * dt
    if self:isInBounds() then
        self.x = self.x + moveX
        self.y = self.y + moveY
    end
end

function Shot:isInBounds()
    local moveX = math.cos(self.rotation + initialShipRotation) * speed * dt
    local moveY = math.sin(self.rotation + initialShipRotation) * speed * dt
    return (self.x + moveX > 0) and (self.y + moveY > 0) and (self.x + moveX < width) and (self.y + moveY < height)
end

function Shot:hasCollided()

end

return Shot