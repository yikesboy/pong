local assets = require("src.assets")
local utils = require("src.utils")
local config = require("config")

local title_state = {
    time = 0
}

local menu = {
    options = {
        {text = "Single Player", mode = "single"},
        {text = "Couch Multiplayer", mode = "couch"},
        {text = "Quit", mode = "quit"}
    },
    selected = 1
}

function title_state:update(dt)
    self.time = self.time + dt
    return nil
end


function title_state:keypressed(key)
    if key then
        love.audio.play(assets.sounds.switch_sfx)
    end
    if key == "down" then
        menu.selected = math.min(menu.selected + 1, #menu.options)
    elseif key == "up" then
        menu.selected = math.max(menu.selected - 1, 1)
    elseif key == "return" then
        local selectedMode = menu.options[menu.selected].mode
        if selectedMode == "quit" then
            love.event.quit()
        else
            return "play", {mode = selectedMode}
        end
    end
end

function title_state:draw()
    -- Title
    local scale = 1 + config.TITLE_BOUNCE_AMPLITUDE * math.sin(self.time + config.TITLE_BOUNCE_SPEED)
    love.graphics.setFont(assets.fonts.title)
    love.graphics.setColor(1,1,1)
    local x,y = utils.get_normalized_coordinates(config.TITLE_TEXT, assets.fonts.title, config.WINDOW_WIDTH / 2, config.WINDOW_HEIGHT * 0.3)

    local text_width = assets.fonts.title:getWidth(config.TITLE_TEXT)
    local text_height = assets.fonts.title:getHeight()
    local center_x = x + text_width * 0.5
    local center_y = y + text_height * 0.5

    love.graphics.push()
    love.graphics.translate(center_x, center_y)
    love.graphics.scale(scale, scale)
    love.graphics.translate(-center_x, -center_y)
    love.graphics.print(config.TITLE_TEXT, x, y)
    love.graphics.pop()

    -- Options
    love.graphics.setFont(assets.fonts.main_large)
    for i, option in ipairs(menu.options) do
        local text = (i == menu.selected) and "> " .. option.text .. " <" or option.text
        local x, y = utils.get_normalized_coordinates(text, assets.fonts.main_large, config.WINDOW_WIDTH / 2, config.WINDOW_HEIGHT * 0.6 + (i - 1) * config.WINDOW_HEIGHT / 10)
        love.graphics.setColor(i == menu.selected and {1, 0.8, 1} or {1, 1, 1})
        love.graphics.print(text, x, y)
    end
end

return title_state
