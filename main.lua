push = require 'push'

--window parameters
WINDOW_HEIGHT = 1280
WINDOW_WIDTH = 720
VIRTUAL_HEIGHT = 512
VIRTUAL_WIDTH = 288

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


function love.draw()
    push:start()

    
    push:finish()
end


function love.resize(w, h)
    push:resize(w, h)
end