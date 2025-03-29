local input = {}

function input.update(paddle)
    if love.keyboard.isDown("up") then
        paddle.y = paddle.y - paddle.speed * dt
    elseif love.keyboard.isDown("down") then
        paddle.y = paddle.y + paddle.speed * dt
    end
end

return input
