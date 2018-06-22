--[[
    CS50
    -- Powerup Class --

    Represents a powerup which will randomly spawn after a brick is hit, descending 
    toward the bottom. If the paddle will pick up it, it will gains a new
    temporary power.
]]

Powerup = Class{}

function Powerup:init(x, y)
    print("init powerup. Coordinate: ")
    print(x, y)
    -- simple positional and dimensional variables
    self.width = 8
    self.height = 8

    self.x = x
    self.y = y

    -- these variables are for keeping track of our velocity on both the
    -- X and Y axis, since the ball can move in two dimensions
    self.dy = -POWERUP_GRAVITY
    self.dx = 0
end

--[[
    Expects an argument with a bounding box, be that a paddle or a brick,
    and returns true if the bounding boxes of this and the argument overlap.
]]
function Powerup:collides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end

function Powerup:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Powerup:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height )
end