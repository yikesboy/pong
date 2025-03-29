local move_ball_to_new_position
local update_ball_velocity
local validate_ball_position
local handle_paddle_collision
    
function update_ball(dt)
    move_ball_to_new_position(dt)
    update_ball_velocity()
    validate_ball_position()
end

function update_paddles(dt)
    if love.keyboard.isDown('up') then
         game.paddles.right.pos_y = math.max(game.paddles.right.pos_y - PADDLE_SPEED * dt, 0)
    end
    if love.keyboard.isDown('down') then
         game.paddles.right.pos_y = math.min(game.paddles.right.pos_y + PADDLE_SPEED * dt, game.window.height-game.paddles.right.height)
    end
    game.paddles.left.pos_y = game.ball.pos_y - game.paddles.left.height * 0.5
    --game.paddles.right.pos_y = game.ball.pos_y - game.paddles.right.height * 0.5
end

function validate_ball_position()
    handle_paddle_collision(game.paddles.left, true)
    handle_paddle_collision(game.paddles.right, false)

    if game.ball.pos_x >= game.window.width + game.ball.radius then
        spawn_ball()
        game.players.left.score = game.players.left.score + 1
        game.players.left.combo = 0
    end

    if game.ball.pos_x <= 0 - game.ball.radius * 2 then
        spawn_ball()
        game.players.right.score = game.players.right.score + 1
        game.players.right.combo = 0
    end

    if game.ball.pos_y >= game.window.height then
        game.ball.velocity.y = -math.abs(game.ball.velocity.y)
        game.sounds.hit_sfx:play()
    end

    if game.ball.pos_y <= 0 then
        game.ball.velocity.y = math.abs(game.ball.velocity.y)
        game.sounds.hit_sfx:play()
    end
end

function move_ball_to_new_position(dt)
    game.ball.pos_x = game.ball.pos_x + game.ball.velocity.x * dt
    game.ball.pos_y = game.ball.pos_y + game.ball.velocity.y * dt
end

function update_ball_velocity()
    game.ball.velocity.x = game.ball.velocity.x * 1.0002
    game.ball.velocity.y = game.ball.velocity.y * 1.0002
end

function handle_paddle_collision(paddle, is_left_paddle)
    if (is_left_paddle and game.ball.pos_x <= (paddle.pos_x + paddle.width)
        and game.ball.pos_y >= paddle.pos_y - game.ball.radius
        and game.ball.pos_y <= (paddle.pos_y + paddle.height))
    or (not is_left_paddle and game.ball.pos_x >= paddle.pos_x
        and game.ball.pos_y >= paddle.pos_y - game.ball.radius
        and game.ball.pos_y <= (paddle.pos_y + paddle.height))
    then
        local hit_pos = game.ball.pos_y - paddle.pos_y
        local segment_size = paddle.height / 8
        local segment = math.floor(hit_pos / segment_size)
        segment = math.max(0, math.min(7, segment))

        local angles = {
            math.rad(60),
            math.rad(45),
            math.rad(30),
            math.rad(0),
            math.rad(0),
            math.rad(-30),
            math.rad(-45),
            math.rad(-60)
        }

        local speed = math.sqrt(game.ball.velocity.x^2 + game.ball.velocity.y^2)
        local angle = angles[segment + 1]
        if is_left_paddle then
            game.ball.velocity.x = speed * math.cos(angle)
        else
            game.ball.velocity.x = -speed * math.cos(angle)
        end
        game.ball.velocity.y = speed * math.sin(angle)
        if is_left_paddle then 
    game.players.left.combo = game.players.left.combo + 1
else 
    game.players.right.combo = game.players.right.combo + 1
end        game.sounds.hit_sfx:play()
    end
end
