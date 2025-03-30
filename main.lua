local config = require("config")
local assets = require("src.assets")
local states = {
    title = require("src.states.title"),
    play = require("src.states.play")
}

local current_state = nil

function love.load()
    love.window.setMode(config.WINDOW_WIDTH, config.WINDOW_HEIGHT)
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
