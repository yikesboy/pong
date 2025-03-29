local config = require("config")

local entities = {
    ball = {
        x = 0,
        y = 0,
        radius = config.BALL_RADIUS,
        speed = { x = 0, y = 0 }
    },
    left_paddle = {
        x = 0,
        y = 0,
        height = config.PADDLE_HEIGHT,
        width = config.PADDLE_WIDTH
    },
    right_paddle = {
        x = 0,
        y = 0,
        height = config.PADDLE_HEIGHT,
        width = config.PADDLE_WIDTH
    },
}

return entities
