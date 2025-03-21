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
    update_ball(dt)
    update_paddles(dt)
end

function love.draw()
    draw_ball()
    draw_paddles()
    draw_scores()
    draw_separator()
end
