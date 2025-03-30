local config = require("config")

local assets = {
    fonts = {},
    sounds = {}
}

function assets.load()
    assets.sounds.background_music = love.audio.newSource("assets/sounds/661104__evapofficial__synth-bass-loop-28.wav", "static")
    assets.sounds.hit_sfx = love.audio.newSource("assets/sounds/4359__noisecollector__pongblipf4.wav", "static")
    assets.fonts.main_large = love.graphics.newFont("assets/fonts/Arcadepix Plus.ttf", config.WINDOW_HEIGHT / 10)
end

return assets
