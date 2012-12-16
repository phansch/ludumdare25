local Shot = require 'Shot'
local Timer = require 'hump.timer'
local PSystems = require 'ParticleSystems'

local Player = {x, y, Shots = {}, spaceDown }
Player.__index = Player

local rotation, speed = 0, 0
local playerImg, imgWidth, imgHeight

local slowdown = false
local initialShipRotation = math.pi * 1.5
local rotationSpeed = 0.015

local shotTimer = Timer.new()
local psystems = PSystems.create()

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

    psystems:initFTLJump()
end

function Player:update(dt)
    --update rotation
    if love.keyboard.isDown('right', 'd') then
        rotation = rotation + math.pi * rotationSpeed
    end
    if love.keyboard.isDown('left', 'a') then
        rotation = rotation - math.pi * rotationSpeed
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

    psystems:update(dt)

    shotTimer:update(dt)
    self:slowdown(dt)
end

function Player:draw()
    love.graphics.draw(playerImg, self.x, self.y, rotation, 1, 1, imgWidth/2, imgHeight/2)

    for i,shot in ipairs(self.Shots) do
        shot:draw()
    end

    --draw ftl jump
    psystems:draw()
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

function Player:FTLJump()
    --activate sound effect
    love.audio.play(sfx_ftl)
    love.audio.rewind(sfx_ftl)

    --enable particle system
    psystems:reset()
    psystems[1]:setPosition(self.x, self.y)
    psystems[1]:start()
end

function Player:updateLocation(dt)
    local moveX = math.cos(rotation + initialShipRotation) * speed * dt
    local moveY = math.sin(rotation + initialShipRotation) * speed * dt
    if self:isInBounds(moveX, moveY) then
        self.x = self.x + moveX
        self.y = self.y + moveY
    end
end

function Player:isInBounds(moveX, moveY)
    return (self.x + moveX > 0) and (self.y + moveY > 0) and (self.x + moveX < width) and (self.y + moveY < height)
end

function Player:fireConstantly()
    -- shoots every 0.2 seconds
    shotTimer:addPeriodic(0.2, function()
        shot = Shot.create(self.x, self.y, rotation)
        shot:load()
        table.insert(self.Shots, shot)
    end)
end

function Player:fireSingle()
    shot = Shot.create(self.x, self.y, rotation)
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