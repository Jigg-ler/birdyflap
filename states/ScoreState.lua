ScoreState = Class{__includes = BaseState}

local bronze = love.graphics.newImage('assets/bronzemedal.png')
local silver = love.graphics.newImage('assets/silvermedal.png')
local gold = love.graphics.newImage('assets/goldmedal.png')

function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof, You Lost', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score =  ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')
    
    if self.score >= 15 then
        love.graphics.draw(gold, VIRTUAL_WIDTH / 2 - 42, VIRTUAL_HEIGHT / 2 - 20)
    elseif self.score >= 10 then
        love.graphics.draw(silver, VIRTUAL_WIDTH / 2 - 42, VIRTUAL_HEIGHT / 2 - 20)
    elseif self.score >= 5 then
        love.graphics.draw(bronze, VIRTUAL_WIDTH / 2 - 42, VIRTUAL_HEIGHT / 2 - 20)
    end

    if self.score >= 5 then
        love.graphics.printf('Press Enter to Play Again', 0, 220, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Press Enter to Play Again', 0, 160, VIRTUAL_WIDTH, 'center')
    end
end