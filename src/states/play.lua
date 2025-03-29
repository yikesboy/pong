local entities = require("src.entities")
local input = require("src.systems.input")
local render = require("src.systems.render")
local physics= require("src.systems.physics")

local state = {}

function state:update(dt)
    input.update(dt, entities.right_paddle);
    -- TODO: call update function of opponent
    physics.update(dt, entities)
end

function state:draw()
    render.draw(entities)
end

return state
