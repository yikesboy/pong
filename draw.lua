local drawNormalizedText

function draw_paddles()
    love.graphics.rectangle("fill", game.paddles.left.pos_x, game.paddles.left.pos_y, game.paddles.left.width, game.paddles.left.height)
    love.graphics.rectangle("fill", game.paddles.right.pos_x, game.paddles.right.pos_y, game.paddles.right.width, game.paddles.right.height)
end

function draw_ball()
    love.graphics.circle("fill", game.ball.pos_x, game.ball.pos_y, game.ball.radius)
end

function draw_scores()
    drawNormalizedText(
        game.players.left.score,
        game.window.width*0.1,
        game.window.height*0.1
    )
    drawNormalizedText(
        game.players.right.score,
        game.window.width*0.9,
        game.window.height*0.1
    )
end

function drawNormalizedText(text, x, y)
    local normalized_x = game.window.font:getWidth(text)
    local normalized_y = game.window.font:getHeight()
    love.graphics.print(
        text,
        x - normalized_x * 0.5,
        y - normalized_y * 0.5
    )
end
