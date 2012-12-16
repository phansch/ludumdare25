-- the part where you die


Gamestate.stage3 = Gamestate.new()
local state = Gamestate.stage3

local Planet = require 'Planet'
local BigShip = require 'BigShip'
local PSystems = require 'ParticleSystems'

local planet = Planet.create()
local bigShip = BigShip.create()
local psystems = PSystems.create()


function state:init()
    bigShip:load()
    planet:load()
end

function state:update(dt)
    player:update(dt)
    jumpRechargeBar:update(dt)


    bigShip:update(dt)
end

function state:draw()
    stars:draw()
    planet:draw()
    player:draw()
    jumpRechargeBar:draw()
    bigShip:draw()
end

function state:keyreleased(key)
    if key == ' ' and not drawUI then
        player:fireSingle()
        player:stopFire()
    end
    if key == 'up' or key == 'w' then
        --if keys are released, slow the ship down
        player:doSlowdown()
    end
    bigShip:fire(player.x, player.y)
end

function state:keypressed(key)
    if key == 'return' and drawUI then --when UI is confirmed
        drawUI = false
        player:stopFire() --stop firing after ui is hidden
    end
    if key == ' ' and not drawUI then
        player:fireConstantly()
    end
end