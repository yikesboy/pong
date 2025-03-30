local input = {}

---Processes user input for each frame.
---@param dt number The time elapsed since the last frame (in seconds).
---@param paddle Paddle
---@param up_key string
---@param down_key string
function input.update(dt, paddle, up_key, down_key)
    if love.keyboard.isDown(up_key) then
        paddle.y = paddle.y - paddle.speed * dt
    elseif love.keyboard.isDown(down_key) then
        paddle.y = paddle.y + paddle.speed * dt
    end
end

return input
