local JumpRechargeBar = { level = 0.1}
JumpRechargeBar.__index = JumpRechargeBar

local x, y, lwidth, lheight = width-620, height-30, 600, 20

function JumpRechargeBar.create(level)
    local jrbar = {}
    setmetatable(jrbar, JumpRechargeBar)
    jrbar.level = level
    return jrbar
end

function JumpRechargeBar:update(dt)
    self.level = self.level + 0.001 * dt
end

function JumpRechargeBar:draw()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print("Jump Drive status", width-170, y+2)
    love.graphics.setLineStyle("rough")
    love.graphics.rectangle("line", x, y, lwidth, lheight)
    love.graphics.rectangle("fill", x, y, lwidth * self.level, lheight)
    love.graphics.setColor(255, 255, 255, 255)
end

return JumpRechargeBar