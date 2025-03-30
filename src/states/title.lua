local assets = require("src.assets")
local utils = require("src.utils")
local config = require("config")


local title = {}

local menu = {
    options = {
        {text = "Single Player", mode = "single"},
        {text = "Couch Multiplayer", mode = "couch"}
    },
    selected = 1
}

function title.update(dt)
    return nil
end


function title:keypressed(key)
    if key == "down" then
        menu.selected = math.min(menu.selected + 1, #menu.options)
    elseif key == "up" then
        menu.selected = math.max(menu.selected - 1, 1)
    elseif key == "return" then
        local selectedMode = menu.options[menu.selected].mode
        return "play", {mode = selectedMode}
    end
end

function title:draw()
    -- Title
    love.graphics.setFont(assets.fonts.title)
    love.graphics.setColor(1,1,1)
    local x,y = utils.get_normalized_coordinates(config.TITLE_TEXT, assets.fonts.title, config.WINDOW_WIDTH / 2, config.WINDOW_HEIGHT * 0.3)
    love.graphics.print(config.TITLE_TEXT, x, y)

    -- Options
    love.graphics.setFont(assets.fonts.main_large)
    for i, option in ipairs(menu.options) do
        local text = (i == menu.selected) and "> " .. option.text .. " <" or option.text
        local x, y = utils.get_normalized_coordinates(text, assets.fonts.main_large, config.WINDOW_WIDTH / 2, config.WINDOW_HEIGHT * 0.6 + (i - 1) * config.WINDOW_HEIGHT / 10)
        love.graphics.setColor(i == menu.selected and {1, 0.8, 1} or {1, 1, 1})
        love.graphics.print(text, x, y)
    end
end

return title
