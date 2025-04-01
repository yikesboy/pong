local config = require("config")
local utils = require("src.utils")
local assets = require("src.assets")

local draw_ball
local draw_paddle
local draw_scores
local draw_seperator

local render = {}

---Draws all the given Entities onto the screen.
---@param entities Entities
function render.draw(entities)
    draw_ball(entities.ball)

    for _, paddle in pairs({entities.left_paddle, entities.right_paddle}) do
        draw_paddle(paddle)
    end

    draw_scores(entities)
    draw_seperator()
    draw_control_hints(entities)
end

---@param ball Ball
function draw_ball(ball)
    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill", ball.x, ball.y, ball.radius)
end

---@param paddle Paddle
function draw_paddle(paddle)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", paddle.x, paddle.y, paddle.width, paddle.height)
end

---@param entities Entities
function draw_scores(entities)
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(assets.fonts.main_large)

    local left_text = tostring(entities.left_paddle.score)
    local left_x, left_y = utils.get_normalized_coordinates(left_text, assets.fonts.main_large, config.WINDOW_WIDTH * 0.25, config.WINDOW_HEIGHT/20)
    love.graphics.print(left_text, left_x, left_y)

    local right_text = tostring(entities.right_paddle.score)
    local right_x, right_y = utils.get_normalized_coordinates(right_text, assets.fonts.main_large, config.WINDOW_WIDTH * 0.75,  config.WINDOW_HEIGHT/20)
    love.graphics.print(right_text, right_x, right_y)
end

function draw_seperator()
    local x = config.WINDOW_WIDTH * 0.5
    local y = 0
    while y <= config.WINDOW_HEIGHT do
        love.graphics.line(x, y, x, y + config.SEPARATOR_STROKE_LENGTH)
        y = y + 2 * config.SEPARATOR_STROKE_LENGTH
    end
end

---@param entities Entities
function draw_control_hints(entities)
    local size = config.WINDOW_WIDTH * 0.03
    local line_width = 6

        draw_key("K", size, line_width, config.WINDOW_WIDTH - size - line_width, config.WINDOW_HEIGHT - 2*size - line_width)
        draw_key("J", size, line_width, config.WINDOW_WIDTH - size - line_width, config.WINDOW_HEIGHT - size - line_width)

    if entities.game_mode == "couch" then
    draw_key("W", size, line_width, 0 + line_width, config.WINDOW_HEIGHT - 2*size - line_width)
    draw_key("S", size, line_width, 0 + line_width, config.WINDOW_HEIGHT - size - line_width)
    end
end

---@param key string
---@param size number
---@param x number
---@param y number
function draw_key(key, size, line_width, x, y)
    love.graphics.setColor(1,1,1)
    love.graphics.setLineWidth(line_width)
    love.graphics.rectangle("line", x, y, size, size)
    love.graphics.setFont(assets.fonts.main_medium)

    local center_x = x + size * 0.5
    local center_y = y + size * 0.5
    local norm_x, norm_y = utils.get_normalized_coordinates(key, assets.fonts.main_medium, center_x, center_y)
    love.graphics.print(key, norm_x + size * 0.07 , norm_y - size * 0.07)
end

return render
