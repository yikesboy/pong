function validate_ball(dt)
    game.ball.pos_x = game.ball.pos_x + game.ball.velocity.x * dt
    game.ball.pos_y = game.ball.pos_y + game.ball.velocity.y * dt

    game.ball.velocity.x = game.ball.velocity.x * 1.0002
    game.ball.velocity.y = game.ball.velocity.y * 1.0002

    if game.ball.pos_x - game.ball.radius <= 0 then
        game.ball.pos_x = game.ball.radius
        game.ball.velocity.x = math.abs(game.ball.velocity.x)
    elseif game.ball.pos_x + game.ball.radius >= game.window.width then
        game.ball.pos_x = game.window.width - game.ball.radius
        game.ball.velocity.x = -math.abs(game.ball.velocity.x)
    end

    if game.ball.pos_y - game.ball.radius <= 0 then
        game.ball.pos_y = game.ball.radius
        game.ball.velocity.y = math.abs(game.ball.velocity.y)
    elseif game.ball.pos_y + game.ball.radius >= game.window.height then
        game.ball.pos_y = game.window.height - game.ball.radius
        game.ball.velocity.y = -math.abs(game.ball.velocity.y)
    end
end
