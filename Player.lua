local Shot = require 'Shot'
local Timer = require 'hump.timer'
local Player = {x, y, Shots = {} }
Player.__index = Player


local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
local angle, speed = 0, 15
local playerImg, imgWidth, imgHeight

local dt = love.timer.getDelta()
local slowdown = false
local initialShipRotation = math.pi * 1.5
local fire

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
    playerImg = love.graphics.newImage("img/player.png")
    imgWidth = playerImg:getWidth()
    imgHeight = playerImg:getHeight()
end

function Player:draw()
    love.graphics.draw(playerImg, self.x, self.y, angle, 1.5, 1.5, imgWidth/2, imgHeight/2)

    if hasFired then
        for i,shot in ipairs(self.Shots) do
            shot:draw()
        end
    end
end

function Player:update()
    --update rotation
    if love.keyboard.isDown('right') then
        angle = angle + math.pi * 0.02
    end
   if love.keyboard.isDown('left') then
        angle = angle - math.pi * 0.02
    end
    -- forward movement
    if love.keyboard.isDown('up') then
        -- make the player move in the direction he is facing
        -- slowing down gradually over time
        self:updateLocation()
    end

    -- shooting
    if fire then
        Timer.addPeriodic(5, function() self:fire() end)

        fire = false
    end

    if hasFired then
        for i,shot in ipairs(self.Shots) do
            shot:update()

            if not shot:isInBounds() then
                self:removeShot(i)
            end
        end
    end
    Timer.update(dt)
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
    local moveX = math.cos(angle + initialShipRotation) * speed * dt
    local moveY = math.sin(angle + initialShipRotation) * speed * dt
    if self:isInBounds(moveX, moveY) then
        self.x = self.x + moveX
        self.y = self.y + moveY
    end
end

function Player:isInBounds(moveX, moveY)
    return (self.x + moveX > 0) and (self.y + moveY > 0) and (self.x + moveX < width) and (self.y + moveY < height)
end

function Player:fire()
    shot = Shot.create(self.x, self.y, angle)
    shot:load()
    table.insert(self.Shots, shot)
    hasFired = true
end

function Player:removeShot(shot)
    table.remove(self.Shots, shot)
end

function love.keyreleased(key)
    if key == 'w' then
        slowdown = true
    end
    if key == ' ' then
        Timer.clear()
    end
end

function love.keypressed(key)
    if key == ' ' then
        fire = true
    end

end

return Player