--[[
    Class, global, and local variable initializations
]]
--Classes
push = require 'push'

Class = require 'class'
require 'Player'

require 'Pipe'
-- class representing pair of pipes together
require 'PipePair'

require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/CountdownState'
require 'states/TitleScreenState'

--window parameters
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

--load assets and their needed values
local background = love.graphics.newImage('assets/background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('assets/ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

--player
local player = Player()

--pipes
local pipePairs = {}
local spawnTimer = 0
local lastY = -PIPE_HEIGHT + math.random(80) + 20

--the game is scrolling
scrolling = true

function love.load()
    love.window.setTitle('Birdy Flap')

    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest', 'nearest')

    smallFont = love.graphics.newFont('font.ttf', 5)
    mediumFont = love.graphics.newFont('flappy.ttf', 8)
    flappyFont = love.graphics.newFont('flappy.ttf', 14)
    hugeFont = love.graphics.newFont('flappy.ttf', 28)
    love.graphics.setFont(flappyFont)

    sounds = {
        ['jump'] = love.audio.newSource('assets/sfx/jump.wav', 'static'),
        ['explosion'] = love.audio.newSource('assets/sfx/explosion.wav', 'static'),
        ['hurt'] = love.audio.newSource('assets/sfx/hurt.wav', 'static'),
        ['score'] = love.audio.newSource('assets/sfx/score.wav', 'static'),
        ['bg_theme'] = love.audio.newSource('assets/sfx/bg_theme.wav', 'static'),
        ['pause'] = love.audio.newSource('assets/sfx/pause.wav', 'static')
    }

    sounds['bg_theme']:setLooping(true)
    sounds['bg_theme']:play()

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- initialize state machine with all state-returning functions
    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function () return ScoreState() end,
        ['countdown'] = function () return CountdownState () end
    }
    gStateMachine:change('title')

    --creates a table 'love.keyboard' i think hahaha
    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end


function love.keypressed(key)
    --equates 'love.keyboard.keysPressed[key]' to true
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end

end

function love.mousepressed(x, y, button)
    love.mouse.buttonsPressed[button] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end

function love.update(dt)
    if scrolling then
        -- scroll background by preset speed * dt, looping back to 0 after the looping point
        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) 
            % BACKGROUND_LOOPING_POINT

        -- scroll ground by preset speed * dt, looping back to 0 after the screen width passes
        groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) 
            % VIRTUAL_WIDTH

    end

    gStateMachine:update(dt)

    -- resets input table
    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end

function love.draw()
    push:start()
        
  -- draw the background at the negative looping point
    love.graphics.draw(background, -backgroundScroll, 0)
    gStateMachine:render()
  -- draw the ground on top of the background, toward the bottom of the screen,
  -- at its negative looping point
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
 
    push:finish()
end