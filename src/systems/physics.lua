local config = require("config")
local assets = require("src.assets")

local physics = {}

---Processes physics for each frame.
---@param dt number The time elapsed since the last frame (in seconds).
---@param entities Entities
function physics.update(dt, entities)
    local ball = entities.ball
    ball.x = ball.x + ball.speed.x * dt
    ball.y = ball.y + ball.speed.y * dt

    physics.vertical_bounds(ball)
    local next_state, params = physics.check_out_of_bounds(entities)

    if next_state then
        return next_state, params
    end

    for _, paddle in pairs({entities.left_paddle, entities.right_paddle}) do
        if physics.paddle_collides(ball, paddle) then
            ball.speed.x = -ball.speed.x
            ball.speed.y = physics.get_vertical_speed(ball, paddle)

            if ball.speed.x > 0 then
                ball.x = paddle.x + paddle.width + ball.radius
            else
                ball.x = paddle.x - ball.radius
            end

            physics.play_collision_sound()
        end
        physics.restrict_paddle(paddle)
    end
end

---Checks and handles the ball going out of bounds on the y-axis.
---@param ball Ball
function physics.vertical_bounds(ball)
    if ball.y < 0 then
        ball.speed.y = -ball.speed.y
        ball.y = 0
        physics.play_collision_sound()
    elseif ball.y > config.WINDOW_HEIGHT then
        ball.speed.y = -ball.speed.y
        ball.y = config.WINDOW_HEIGHT
        physics.play_collision_sound()
    end
end

---Checks and handles the ball colliding with the given paddle.
---@param ball Ball
---@param paddle Paddle
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
        physics.play_round_loss_sound()
        entities.right_paddle.score =  entities.right_paddle.score + 1
        if entities.right_paddle.score >= config.SCORE_TO_WIN then
            return "end", {winner = "right", mode = entities.game_mode}
        end
        physics.reset_ball(entities.ball)
    elseif entities.ball.x > config.WINDOW_WIDTH then
        physics.play_round_loss_sound()
        entities.left_paddle.score =  entities.left_paddle.score + 1
        if entities.left_paddle.score >= config.SCORE_TO_WIN then
            return "end", {winner = "left", mode = entities.game_mode}
        end
        physics.reset_ball(entities.ball)
    end
end

---@param ball Ball
function physics.reset_ball(ball)
    ball.x = config.WINDOW_WIDTH / 2
    ball.y = config.WINDOW_HEIGHT / 2
    ball.speed.x = config.BALL_SPEED * (math.random(0, 1) == 0 and 1 or -1)
    ball.speed.y = config.BALL_SPEED * math.random() * (math.random(0, 1) == 0 and 1 or -1)
end

---Calculates the reflection angle and translates it to vertical speed.
---@param ball Ball
---@param paddle Paddle
---@return number
function physics.get_vertical_speed(ball, paddle)
    local hit_position = ball.y - paddle.y
    local segment_size = paddle.height / config.SEGMENT_COUNT

    local segment = math.floor(hit_position / segment_size)
    segment = math.max(0, math.min(7, segment))

    local speed = math.sqrt(ball.speed.x^2 + ball.speed.y^2)
    local angle = config.REFLECTION_ANGLES[segment + 1]

    return speed * math.sin(math.rad(angle))
end

---Plays hit_sfx from the assets store
function physics.play_collision_sound()
    love.audio.play(assets.sounds.hit_sfx)
end

---Plays round_loss from the assets store
function physics.play_round_loss_sound()
    love.audio.play(assets.sounds.round_loss)
end


return physics
