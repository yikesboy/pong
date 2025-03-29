local config = require("config")

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
        width = config.PADDLE_WIDTH,
        speed = config.PADDLE_SPEED,
        score = 0
    },
    right_paddle = {
        x = 0,
        y = 0,
        height = config.PADDLE_HEIGHT,
        width = config.PADDLE_WIDTH,
        speed = config.PADDLE_SPEED,
        score = 0
    },
}

return entities
