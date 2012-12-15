local Shot = require 'Shot'
local Timer = require 'hump.timer'
local Player = {x, y, Shots = {} }
Player.__index = Player


local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
local rotation, speed = 0, 0
local playerImg, imgWidth, imgHeight

local dt = love.timer.getDelta()
local slowdown = false
local initialShipRotation = math.pi * 1.5
local rotationSpeed = 0.02
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

    sfx_shoot = love.audio.newSource("audio/shoot.wav")
end

function Player:draw()
    love.graphics.draw(playerImg, self.x, self.y, rotation, 1, 1, imgWidth/2, imgHeight/2)

    if hasFired then
        for i,shot in ipairs(self.Shots) do
            shot:draw()
        end
    end
end

function Player:update()
    --update rotation
    if love.keyboard.isDown('right', 'd') then
        rotation = rotation + math.pi * rotationSpeed
    end
    if love.keyboard.isDown('left', 'a') then
        rotation = rotation - math.pi * rotationSpeed
    end
    -- forward movement
    if love.keyboard.isDown('up', 'w') then
        speed = 15
        self:updateLocation()
    end
    if love.keyboard.isDown('down', 's') then
        speed = -5
        self:updateLocation()
    end

    -- shooting
    if fire then
        self:fire() -- hammering space key
        Timer.addPeriodic(5, function() self:fire() end) -- holding space key

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

    self:slowdown()

    Timer.update(dt)
end

function Player:slowdown(ultimate)
    if slowdown == true then
        speed = speed - 1
        self:updateLocation()
        if speed <= 0 then
            speed = 15
            slowdown = false
        end
    end
end

function Player:updateLocation()
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

function Player:fire()
    shot = Shot.create(self.x, self.y, rotation)
    shot:load()
    table.insert(self.Shots, shot)
    --love.audio.play(sfx_shoot)
    --love.audio.rewind(sfx_shoot)
    hasFired = true
end

function Player:removeShot(shot)
    table.remove(self.Shots, shot)
end

function love.keyreleased(key)
    if key == 'up' or key == 'w' then
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