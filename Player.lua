local Shot = require 'Shot'
local Player = {x, y, Shots = {}}
Player.__index = Player
local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
local angle, speed = 0, 20
local playerImg, imgWidth, imgHeight

local dt = love.timer.getDelta()
local slowdown = false
local initialShipRotation = math.pi * 1.5

local Shots = {}
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
        for i,shot in ipairs(Shots) do
            shot:draw()
        end
    end
end

function Player:update()
    --update rotation
    if love.keyboard.isDown('d') then
        angle = angle + math.pi * 0.02
    end
   if love.keyboard.isDown('a') then
        angle = angle - math.pi * 0.02
    end
    -- forward movement
    if love.keyboard.isDown('w') then
        -- make the player move in the direction he is facing
        -- slowing down gradually over time
        self:updateLocation()
    end

    --shooting
    if fire then
        self:fire()
        fire = false
    end

    if hasFired then
        for i,shot in ipairs(Shots) do
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

function Player:fire(destX, destY)
    shot = Shot.create(self.x, self.y, angle)
    shot:load()
    table.insert(Shots, shot)
    hasFired = true
end

function Player:removeShot(shot)
    print(shot)
    table.remove(Shots, shot)
end

function love.keyreleased(key)
   if key == "w" then
      slowdown = true
   end
end

function love.keypressed(key)
    -- ignore non-printable characters (see http://www.ascii-code.com/)
    if key == ' ' then
        fire = true
    end
end

return Player