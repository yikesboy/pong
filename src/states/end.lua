local config = require("config")
local utils = require("src.utils")
local assets = require("src.assets")

local end_state = {
    winner = nil,
    game_mode = nil,
    menu = {
        options = {
            { text = "Play Again", mode = "play"},
            { text = "Return to Main Menu", mode = "title"}
        },
        selected = 1
    }
}

function end_state:init(params)
    self.winner = params.winner
    self.game_mode = params.mode
end

function end_state:update(dt)
    return nil
end

function end_state:keypressed(key)
    if key then
        love.audio.play(assets.sounds.switch_sfx)
    end
    if key == "j" then
        self.menu.selected = math.min(self.menu.selected + 1, #self.menu.options)
    elseif key == "k" then
        self.menu.selected = math.max(self.menu.selected - 1, 1)
    elseif key == "space" then
        local selected_mode = self.menu.options[self.menu.selected].mode
        if selected_mode == "title" then
            return "title"
        elseif selected_mode == "play" then
            return "play", { mode = self.game_mode}
        end
    end
end

function end_state:draw()
    love.graphics.setFont(assets.fonts.title_medium)
    love.graphics.setColor(1,1,1)
    local winner_text = self.winner == "left" and "Left Player Wins!" or "Right Player Wins!"
    local x, y = utils.get_normalized_coordinates(winner_text, assets.fonts.title_medium, config.WINDOW_WIDTH * 0.5, config.WINDOW_HEIGHT * 0.3)
    love.graphics.print(winner_text, x, y)

    love.graphics.setFont(assets.fonts.main_large)
    for i, option in ipairs(self.menu.options) do
        local text = (i == self.menu.selected) and "> " .. option.text .. " <" or option.text
        local x, y = utils.get_normalized_coordinates(text, assets.fonts.main_large, config.WINDOW_WIDTH / 2, config.WINDOW_HEIGHT * 0.6 + (i - 1) * config.WINDOW_HEIGHT / 10)
        love.graphics.setColor(i == self.menu.selected and {1, 0.8, 1} or {1, 1, 1})
        love.graphics.print(text, x, y)
    end

    love.graphics.setFont(assets.fonts.main_small)
    love.graphics.setColor(1,1,1)
    local control_hints = "J - Down   |   Space - Select Option   |   K - Up"
    local x, y = utils.get_normalized_coordinates(control_hints, assets.fonts.main_small, config.WINDOW_WIDTH * 0.5, config.WINDOW_HEIGHT * 0.95)
    love.graphics.print(control_hints, x, y)
end

return end_state
