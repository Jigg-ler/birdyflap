Player = Class{}

local GRAVITY = 25

function Player:init()
    self.image = love.graphics.newImage('assets/player.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    self.dy = 0
end

function Player:render()
    love.graphics.draw(self.image, self.x, self.y)
end

function Player:collides(pipe)
    --AABB collision
    if (self.x + 2) + (self.width - 4) >= pipe.x and (self.x + 2) <= pipe.x + PIPE_WIDTH then
        if (self.y + 2) + (self.height - 4) >= pipe.y and (self.y + 2) <= pipe.y + PIPE_HEIGHT then
            return true
        end
    end

    return false
end

function Player:update(dt)
    --adds gravity to the player's velocity
    self.dy = self.dy + GRAVITY * dt

    --if user pressed space, adjusts velocity
    if love.keyboard.wasPressed('space') then
        self.dy = -5
    end

    --adds the current velocity to the player's y position
    self.y = self.y + self.dy
end