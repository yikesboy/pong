require("game")
require("setup")
require("update")
require("draw")

function love.load()
    game_setup()
    spawn_ball()
    spawn_paddles()
end

function love.update(dt)
    validate_ball(dt)
end

function love.draw()
    draw_ball()
    draw_paddles()
end
