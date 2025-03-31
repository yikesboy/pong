local entities = require("src.entities")
local input = require("src.systems.input")
local render = require("src.systems.render")
local physics= require("src.systems.physics")
local ai = require("src.systems.ai")
local config = require("config")

local state = {}
local game_mode = "single"

function state:init(params)
    game_mode = params and params.mode or "single"
    entities.left_paddle.score = 0
    entities.right_paddle.score = 0
    entities.left_paddle.y = (config.WINDOW_HEIGHT - entities.left_paddle.height) / 2
    entities.right_paddle.y = (config.WINDOW_HEIGHT - entities.right_paddle.height) / 2
    physics.reset_ball(entities.ball)
end

function state:update(dt)
    input.update(dt, entities.right_paddle, "up", "down");

    if game_mode == "single" then
        ai.update(dt, entities)
    elseif game_mode == "couch" then
        input.update(dt, entities.left_paddle, "w", "s");
    end

    entities.game_mode = game_mode
    local next_state, params = physics.update(dt, entities)
    if next_state then
        return next_state, params
    end

    return nil
end

function state:draw()
    render.draw(entities)
end

function state:keypressed(key)
    if key == "escape" then
        return "pause", { previous_state = state }
    end
end

return state
