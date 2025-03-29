local config = require("config")
local assets = require("src.assets")
local states = {
    play = require("src.states.play")
}

local current_state = nil

function love.load()
    love.window.setMode(config.WINDOW_WIDTH, config.WINDOW_HEIGHT)
    assets.load()
    current_state = states.play
end

function love.update(dt)
    current_state:update(dt)
end

function love.draw()
    current_state:draw()
end
