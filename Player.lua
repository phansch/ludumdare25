local Shot = require 'Shot'
local Timer = require 'hump.timer'

local Player = {x, y, Shots = {}, spaceDown }
Player.__index = Player

local rotation, speed = 0, 0
local playerImg, imgWidth, imgHeight

local slowdown = false
local initialShipRotation = math.pi * 1.5
local rotationSpeed = 0.015

local shotTimer = Timer.new()

function Player.create()
    local player = {}
    setmetatable(player, Player)
    player.x = width/2
    player.y = height/2
    player.spaceDown = false
    return player
end

function Player:load()
    playerImg = love.graphics.newImage("img/player.png")
    imgWidth = playerImg:getWidth()
    imgHeight = playerImg:getHeight()
end

function Player:update(dt)
    --update rotation
    if love.keyboard.isDown('right', 'd') then
        rotation = rotation + math.pi * rotationSpeed
        rotation = self:lowRotation(rotation)
    end
    if love.keyboard.isDown('left', 'a') then
        rotation = rotation - math.pi * rotationSpeed
        rotation = self:lowRotation(rotation)
    end
    -- forward movement
    if love.keyboard.isDown('up', 'w') then
        speed = 200
        self:updateLocation(dt)
    end
    if love.keyboard.isDown('down', 's') then
        speed = -50
        self:updateLocation(dt)
    end

    --update all shots
    for i,shot in ipairs(self.Shots) do
        shot:update()

        if not shot:isInBounds() then
            self:removeShot(i)
        end
    end

    shotTimer:update(dt)
    self:slowdown(dt)
end

function Player:draw()
    love.graphics.draw(playerImg, self.x, self.y, rotation, 1, 1, imgWidth/2, imgHeight/2)

    for i,shot in ipairs(self.Shots) do
        shot:draw()
    end
end

function Player:slowdown(dt)
    if slowdown == true then
        speed = speed - 10
        self:updateLocation(dt)
        if speed <= 0 then
            speed = 200
            slowdown = false
        end
    end
end

function Player:updateLocation(dt)
    local moveX = math.cos(rotation + initialShipRotation) * speed * dt
    local moveY = math.sin(rotation + initialShipRotation) * speed * dt
    self.x = self.x + moveX
    self.y = self.y + moveY

    self:warp(moveX, moveY)
end

-- Keeps rotation between 0 and pi*2
function Player:lowRotation(rotation)
    if rotation > math.pi * 2 then
        rotation = rotation - math.pi * 2
    end
    if rotation < 0 then
        rotation = rotation + math.pi * 2
    end
    return rotation
end

function Player:warp(moveX, moveY)
    if self.x + moveX < 0 then
        self.x = width
    end
    if self.x + moveX > width then
        self.x = 0
    end
    if self.y + moveY < 0 then
        self.y = height
    end
    if self.y + moveY > height then
        self.y = 0
    end
end

function Player:fireConstantly()
    -- shoots every 0.2 seconds
    shotTimer:addPeriodic(0.2, function()
        self:createShots()
    end)
end

function Player:fireSingle()
    self:createShots()
end

function Player:createShots()
    local shotOffsetX, shotOffsetY = 7, 7
    if (rotation > math.pi/2 and rotation < math.pi) or (rotation > math.pi*1.5 and rotation < math.pi*2) then
        shotOffsetY = shotOffsetY * -1
    end

    shot = Shot.create(self.x+shotOffsetX, self.y+shotOffsetY, rotation)
    shot:load()
    table.insert(self.Shots, shot)
    shot = Shot.create(self.x-shotOffsetX, self.y-shotOffsetY, rotation)
    shot:load()
    table.insert(self.Shots, shot)
end

function Player:removeShot(shot)
    table.remove(self.Shots, shot)
end

function Player:doSlowdown()
    slowdown = true
end

function Player:stopFire()
    shotTimer:clear()
end

return Player