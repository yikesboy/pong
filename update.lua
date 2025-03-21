local move_ball_to_new_position
local update_ball_velocity
local validate_ball_position
    
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
end

function validate_ball_position()
    if game.ball.pos_x <= (game.paddles.left.pos_x + game.paddles.left.width)
        and game.ball.pos_y >= game.paddles.left.pos_y - game.ball.radius
        and game.ball.pos_y <= (game.paddles.left.pos_y + game.paddles.left.height)
    then
       game.ball.velocity.x = math.abs(game.ball.velocity.x)
    end

    if game.ball.pos_x >= game.paddles.right.pos_x
        and game.ball.pos_y >= game.paddles.right.pos_y - game.ball.radius
        and game.ball.pos_y <= game.paddles.right.pos_y + game.paddles.right.height
    then
       game.ball.velocity.x = -math.abs(game.ball.velocity.x)
    end

    if game.ball.pos_x >= game.window.width + game.ball.radius then
        spawn_ball()
        game.players.left.score = game.players.left.score + 1
    end

    if game.ball.pos_x <= 0 - game.ball.radius * 2 then
        spawn_ball()
        game.players.right.score = game.players.right.score + 1
    end

    if game.ball.pos_y >= game.window.height then
        game.ball.velocity.y = -math.abs(game.ball.velocity.y)
    end

    if game.ball.pos_y <= 0 then
        game.ball.velocity.y = math.abs(game.ball.velocity.y)
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
