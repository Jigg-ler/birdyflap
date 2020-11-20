--[[
    Class, global, and local variable initializations
]]
--Classes
push = require 'push'

Class = require 'class'
require 'Player'

--window parameters
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

--load assets
local background = love.graphics.newImage('assets/background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('assets/ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

--player
local player = Player()

function love.load()
    love.window.setTitle('Birdy Flap')

    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end


function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    end

end

function love.update(dt)
    -- scroll background by preset speed * dt, looping back to 0 after the looping point
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) 
        % BACKGROUND_LOOPING_POINT

    -- scroll ground by preset speed * dt, looping back to 0 after the screen width passes
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) 
        % VIRTUAL_WIDTH
end

function love.draw()
    push:start()
        
  -- draw the background at the negative looping point
  love.graphics.draw(background, -backgroundScroll, 0)

  -- draw the ground on top of the background, toward the bottom of the screen,
  -- at its negative looping point
  love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

  player:render()
  
    push:finish()
end


function love.resize(w, h)
    push:resize(w, h)
end