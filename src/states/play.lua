local entities = require("src.entities")
local input = require("src.systems.input")
local render = require("src.systems.render")
local physics= require("src.systems.physics")
local ai = require("src.systems.ai")

local state = {}
local game_mode = "single"

function state:init(params)
   game_mode = params and params.mode or "single"
end

function state:update(dt)
    input.update(dt, entities.right_paddle, "up", "down");

    if game_mode == "single" then
        ai.update(dt, entities)
    elseif game_mode == "couch" then
        input.update(dt, entities.left_paddle, "w", "s");
    end

    physics.update(dt, entities)
    return nil
end

function state:draw()
    render.draw(entities)
end

return state
