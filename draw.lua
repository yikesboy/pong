function draw_paddles()
    love.graphics.rectangle("fill", game.paddles.left.pos_x, game.paddles.left.pos_y, game.paddles.left.width, game.paddles.left.height)
    love.graphics.rectangle("fill", game.paddles.right.pos_x, game.paddles.right.pos_y, game.paddles.right.width, game.paddles.right.height)
end

function draw_ball()
    love.graphics.circle("fill", game.ball.pos_x, game.ball.pos_y, game.ball.radius)
end

