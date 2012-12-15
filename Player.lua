local Player = {x, y}
Player.__index = Player
local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
local angle, speed = 0, 20
local img, imgWidth, imgHeight

local dt = love.timer.getDelta()
local slowdown = false
local initialShipRotation = math.pi * 1.5

function Player.create()
    local player = {}
    setmetatable(player, Player)
    player.x = 300
    player.y = 300
    player.dirX = 0
    player.dirY = 0
    return player
end


function Player:load()
    img = love.graphics.newImage("player.png")
    imgWidth = img:getWidth()
    imgHeight = img:getHeight()
end

function Player:draw()
    love.graphics.draw(img, self.x, self.y, angle, 1, 1, imgWidth/2, imgHeight/2)
end

function Player:update()
    --update rotation
    if (love.keyboard.isDown('d')) then
        angle = angle + math.pi * 0.02
    end
   if (love.keyboard.isDown('a')) then
        angle = angle - math.pi * 0.02
    end
    -- forward movement
    if (love.keyboard.isDown('w')) then
        -- make the player move in the direction he is facing
        -- slowing down gradually over time
        self:updateLocation()
    end
end

function Player:slowdown(ultimate)
    if slowdown == true then
        speed = speed - 1.5
        self:updateLocation()
        if speed <= 0 then
            speed = 20
            slowdown = false
        end
    end
end

function Player:updateLocation()
    moveX = math.cos(angle + initialShipRotation) * speed * dt
    moveY = math.sin(angle + initialShipRotation) * speed * dt
    if self:isInBounds(moveX, moveY) then
        self.x = self.x + moveX
        self.y = self.y + moveY
    end
end

function Player:isInBounds(moveX, moveY)
    return (self.x + moveX > 0) and (self.y + moveY > 0) and (self.x + moveX < width) and (self.y + moveY < height)
end

function love.keyreleased(key)
   if key == "w" then
      slowdown = true
   end
end

return Player