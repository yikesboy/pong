local input = {}

---Processes user input for each frame.
---@param dt number The time elapsed since the last frame (in seconds).
---@param paddle Paddle
function input.update(dt, paddle)
    if love.keyboard.isDown("up") then
        paddle.y = paddle.y - paddle.speed * dt
    elseif love.keyboard.isDown("down") then
        paddle.y = paddle.y + paddle.speed * dt
    end
end

return input
