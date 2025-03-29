function game_setup()
    love.window.setMode(0, 0, { fullscreen = true })
    game.window.width, game.window.height = love.graphics.getDimensions()
    game.window.font = love.graphics.newFont(15*10)
    love.graphics.setFont(game.window.font)
    game.window.color = love.graphics.setColor(1, 1, 1)
    game.window.seperator.stroke_length = (game.window.height * 0.5) / 60
end

function sound_setup()
    game.sounds.background_music = love.audio.newSource("assets/sounds/661104__evapofficial__synth-bass-loop-28.wav", "static")
    game.sounds.hit_sfx = love.audio.newSource("assets/sounds/4359__noisecollector__pongblipf4.wav", "static")
    game.sounds.background_music:play()
    game.sounds.background_music:setLooping(true)
end

function spawn_ball()
    math.randomseed(os.time())
    game.ball.pos_x = math.random(game.window.width * 0.3, game.window.width * 0.7)
    game.ball.pos_y = math.random(game.window.height * 0.3, game.window.height * 0.7)
    game.ball.velocity.x = game.ball.pos_x >= game.window.width * 0.5 and -BALL_SPEED or BALL_SPEED
    game.ball.velocity.y = game.ball.pos_y >= game.window.height * 0.5 and -BALL_SPEED or BALL_SPEED
end

function spawn_paddles()
    game.paddles.left.pos_x = game.window.width * 0.02
    game.paddles.left.pos_y = game.window.height * 0.5 - game.paddles.left.height * 0.5
    game.paddles.right.pos_x = game.window.width * 0.98 - game.paddles.right.width
    game.paddles.right.pos_y = game.window.height * 0.5 - game.paddles.right.height * 0.5
end

