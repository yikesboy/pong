local config = require("config")

local ai = {
    target_position = nil,
    reaction_timer = 0
}

---Calculates the moves of the AI opponent for each frame.
---@param dt number The time elapsed since the last frame (in seconds).
---@param entities Entities
function ai.update(dt, entities)
    ai.reaction_timer = ai.reaction_timer - dt

    if ai.reaction_timer <= 0 then
        local positional_error = math.random(-config.AI_ERROR_MARGIN, config.AI_ERROR_MARGIN)
        ai.target_position = entities.ball.y + positional_error - config.PADDLE_HEIGHT * 0.5
        ai.reaction_timer = config.AI_REACTION_TIME
    end

    if ai.target_position then
        local current_position = entities.left_paddle.y
        local distance = ai.target_position - current_position
        local movement = distance * config.AI_LERP_FACTOR * dt

        if math.abs(movement) > config.PADDLE_SPEED * dt then
            movement = config.PADDLE_SPEED * dt * (movement > 0 and 1 or -1)
        end

        entities.left_paddle.y = current_position + movement
    end
end

return ai
