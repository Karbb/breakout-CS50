--[[
    CS50
    -- Powerup Class --

    Represents a powerup which will randomly spawn after a brick is hit, descending 
    toward the bottom. If the paddle will pick up it, it will gains a new
    temporary power.
]]

Powerup = Class{}

function Powerup:init(x, y, type)
    -- simple positional and dimensional variables
    self.width = 8
    self.height = 8

    self.x = x
    self.y = y

    -- these variables are for keeping track of our velocity on both the
    -- X and Y axis, since the ball can move in two dimensions
    self.dy = POWERUP_GRAVITY
    self.dx = 0
    self.type = type
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

function Powerup:activate(game)
    if(self.type == POWERUP_TYPE[1]) then
        
        index = rnd(1, #game.balls)
        motherBall = game.balls[index]

        tempBall1 = Ball()
        lazyClone(motherBall, tempBall1)
        tempBall1.dy = tempBall1.dy - 20

        tempBall2 = Ball()
        lazyClone(motherBall, tempBall2)
        tempBall2.skin = math.random(7)

        table.insert(game.balls, tempBall1)
        table.insert(game.balls, tempBall2)
    end
end

function Powerup:destroy()
    self = nil
end

function Powerup:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height )
end

function lazyClone(ball, tempBall)
    tempBall.x = ball.x
    tempBall.y = ball.y
    tempBall.dx = ball.dx
    tempBall.dy = ball.dy
    tempBall.skin = math.random(7)

    if(tempBall.dy > 0) then
        tempBall.dy = - tempBall.dy
    end
end