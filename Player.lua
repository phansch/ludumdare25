local Player = {x, y}
Player.__index = Player
local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
local angle = 0
local img, imgWidth, imgHeight
local speed = 40
local dt = love.timer.getDelta()
local slowdown = false

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
    --love.graphics.setColor(255, 0, 0)
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

    self:slowdown()
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
    if self:isInBounds() then
        self.y = self.y + math.sin(angle + math.pi/2) * speed * dt
        self.x = self.x + math.cos(angle + math.pi/2) * speed * dt
    else
        --slowdown to zero, slowly
    end
end

function Player:isInBounds()
    return self.x > 0 and self.y > 0 and self.x < width and self.y < height
end

function love.keyreleased(key)
   if key == "w" then
      slowdown = true
   end
end

return Player