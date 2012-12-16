local Stars = {}
Stars.__index = Stars

function Stars.create()
    local stars = {}
    setmetatable(stars, Stars)
    return stars
end

function Stars:load()
    --create stars
    for i=1,height,1 do
        self[i] = { ["x"] = math.random(0, width), ["y"] = i }
    end
end

function Stars:draw()
    --draw stars
    for i=1,height,1 do
        love.graphics.point(self[i].x, self[i].y)
    end
end

return Stars