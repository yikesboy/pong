local assets = require("src.assets")

local utils = {}

--- Calculates normalized coordinates such that the text is centered at the given position.
--- @param text string The text whose dimensions are used for normalization.
--- @param font table The font that is going to be used to normalize.
--- @param x number The original x-coordinate.
--- @param y number The original y-coordinate.
--- @return number x_norm The normalized x-coordinate.
--- @return number y_norm The normalized y-coordinate.
function utils.get_normalized_coordinates(text, font, x, y)
    local x_norm = x - font:getWidth(text) * 0.5
    local y_norm = y - font:getHeight() * 0.5
    return x_norm, y_norm
end

return utils
