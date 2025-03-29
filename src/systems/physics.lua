local config = require("config")

local physics = {}

---Processes physics for each frame.
---@param dt number The time elapsed since the last frame (in seconds).
---@param entities Entities
function physics.update(dt, entities)
    local ball = entities.ball
    ball.x = ball.x + ball.speed.x * dt
    ball.y = ball.y + ball.speed.y * dt

    physics.vertical_bounds(ball)
    physics.check_out_of_bounds(entities)

    for _, paddle in pairs({entities.left_paddle, entities.right_paddle}) do
        if physics.paddle_collides(ball, paddle) then
            ball.speed.x = -ball.speed.x
        end
        physics.restrict_paddle(paddle)
    end
end

function physics.vertical_bounds(ball)
    if ball.y < 0 or ball.y > config.WINDOW_HEIGHT then
        ball.speed.y = -ball.speed.y
    end
end

function physics.paddle_collides(ball, paddle)
    return ball.x + ball.radius > paddle.x and
        ball.x - ball.radius < paddle.x + paddle.width and
        ball.y + ball.radius > paddle.y and
        ball.y - ball.radius < paddle.y + paddle.height
end

---Keeps paddles inside of the window bounds.
---@param paddle Paddle
function physics.restrict_paddle(paddle)
    local min = 0
    local max = config.WINDOW_HEIGHT - paddle.height
    paddle.y = math.max(min, math.min(max, paddle.y))
end

---Check if ball leaves x-axis bounds and handle it.
---@param entities Entities
function physics.check_out_of_bounds(entities)
    if entities.ball.x < 0 then
        entities.left_paddle.score =  entities.left_paddle.score + 1
        physics.reset_ball(entities.ball)
    elseif entities.ball.x > config.WINDOW_WIDTH then
        entities.right_paddle.score =  entities.right_paddle.score + 1
        physics.reset_ball(entities.ball)
    end
end

---@param ball Ball
function physics.reset_ball(ball)
    ball.x = config.WINDOW_WIDTH / 2
    ball.y = config.WINDOW_HEIGHT / 2
    ball.speed.x = config.BALL_SPEED * (math.random(0, 1) == 0 and 1 or -1)
    ball.speed.y = 0
end

return physics
