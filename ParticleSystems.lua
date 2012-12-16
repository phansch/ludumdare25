local ParticleSystems = { }
ParticleSystems.__index = ParticleSystems

function ParticleSystems.create()
    local psystems = {}
    setmetatable(psystems, ParticleSystems)
    return psystems
end

function ParticleSystems:draw()
    love.graphics.setBlendMode("additive")

    for i,system in ipairs(self) do
        love.graphics.draw(system, 0, 0)
    end

    love.graphics.setBlendMode("alpha")
end

function ParticleSystems:update(dt)
    for i,system in ipairs(self) do
        system:update(dt)
    end
end

function ParticleSystems:initExplosion()
    local particle_explosion = love.graphics.newImage("img/particle_explosion.png")
    local p = love.graphics.newParticleSystem(particle_explosion, 1000)
    p:setEmissionRate(1000)
    p:setSpeed(300, 400)
    p:setSizes(3, 1)
    p:setColors(220, 105, 20, 255, 194, 30, 18, 0)
    p:setLifetime(0.1)
    p:setParticleLife(0.2)
    p:setDirection(0)
    p:setSpread(360)
    p:setTangentialAcceleration(10)
    p:setRadialAcceleration(500)
    p:stop()
    table.insert(self, p)
end

function ParticleSystems:initFTLJump()
    local particle_jump = love.graphics.newImage("img/particle_explosion.png")
    local p = love.graphics.newParticleSystem(particle_jump, 1000)
    p:setEmissionRate(500)
    p:setSpeed(160, 600)
    p:setSizes(3, 1)
    p:setColors(220, 205, 240, 100, 194, 30, 18, 0)
    p:setLifetime(0.3)
    p:setParticleLife(0.3)
    p:setDirection(0)
    p:setSpread(360)
    p:setTangentialAcceleration(310)
    p:setRadialAcceleration(500)
    p:stop()
    table.insert(self, p)
end

return ParticleSystems