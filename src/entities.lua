local config = require("config")
local entities = {}

---@class Ball
---@field x number
---@field y number
---@field radius number
---@field speed { x: number, y: number }

---@class Paddle
---@field x number
---@field y number
---@field height number
---@field width number
---@field speed number
---@field score number

---@class Entities
---@field ball Ball
---@field left_paddle Paddle
---@field right_paddle Paddle

function entities.create()
    return {
    ball = {
        x = config.WINDOW_WIDTH / 2,
        y = config.WINDOW_HEIGHT / 2,
        radius = config.BALL_RADIUS,
        speed = {
            x = config.BALL_SPEED * (math.random(0,1) == 0 and 1 or -1),
            y = config.BALL_SPEED * math.random() * (math.random(0, 1) == 0 and 1 or -1)
        }
    },
    left_paddle = {
        x = 0,
        y = (config.WINDOW_HEIGHT - config.PADDLE_HEIGHT) / 2,
        height = config.PADDLE_HEIGHT,
        width = config.PADDLE_WIDTH,
        speed = config.PADDLE_SPEED,
        score = 0
    },
    right_paddle = {
        x = config.WINDOW_WIDTH - config.PADDLE_WIDTH,
        y = (config.WINDOW_HEIGHT - config.PADDLE_HEIGHT) / 2,
        height = config.PADDLE_HEIGHT,
        width = config.PADDLE_WIDTH,
        speed = config.PADDLE_SPEED,
        score = 0
    },
    game_mode = nil
}
end

function entities.set(new_entities)
    for key, value in pairs(new_entities) do
        entities[key] = value
    end
end

return entities
