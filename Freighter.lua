local Freighter = {x, y}
Freighter.__index = Freighter

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

function Freighter.create()
    local freighter = {}
    setmetatable(freighter, Freighter)
    freighter.x = 200
    freighter.y = 200
    return freighter
end


function Freighter:draw()

end

function Freighter:update()

end

return Freighter