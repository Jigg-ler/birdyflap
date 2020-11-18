push = require 'push'

--window parameters
WINDOW_HEIGHT = 1280
WINDOW_WIDTH = 720
VIRTUAL_HEIGHT = 512
VIRTUAL_WIDTH = 288

function love.load()

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
