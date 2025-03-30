local config = require("config")
local assets = require("src.assets")
local states = {
    title = require("src.states.title"),
    play = require("src.states.play")
}
local entities = require("src.entities")


local current_state = nil

function love.load()
    love.window.setFullscreen(true, "desktop")
    config.BALL_SPEED = config.BALL_SPEED * ( love.graphics.getWidth() / config.WINDOW_WIDTH)
    config.WINDOW_WIDTH = love.graphics.getWidth()
    config.WINDOW_HEIGHT = love.graphics.getHeight()

    entities.set(entities.create())
    assets.load()
    current_state = states.title
end

function love.update(dt)
    local next_state, params = current_state:update(dt)
    if next_state and states[next_state] then
        current_state = states[next_state]
        if current_state.init then
            current_state:init(params)
        end
    end
end

function love.draw()
    current_state:draw()
end

function love.keypressed(key)
    if current_state.keypressed then
        local next_state, params = current_state:keypressed(key)
        if next_state and states[next_state] then
            current_state = states[next_state]
            if current_state.init then
                current_state:init(params)
            end
        end
    end
end
