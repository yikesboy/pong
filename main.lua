local BALL_RADIUS = 20
local BALL_SPEED = 1000
local PADDLE_HEIGHT = 150
local PADDLE_WIDTH = 20
local PADDLE_SPEED = 1400

local game = {
    window = {
        width = 0,
        height = 0
    },
    paddles = {
        left = {
            pos_x = 0,
            pos_y = 0,
            height = PADDLE_HEIGHT,
            width = PADDLE_WIDTH,
        },
        right = {
            pos_x = 0,
            pos_y = 0,
            height = PADDLE_HEIGHT,
            width = PADDLE_WIDTH,
        }
    },
    ball = {
        pos_x = 0,
        pos_y = 0,
        radius = BALL_RADIUS,
        velocity = {x = 0, y = 0}
    }
}

function love.load()
    love.window.setMode(0, 0, { fullscreen = true })
    game.window.width, game.window.height = love.graphics.getDimensions()

    math.randomseed(os.time())
    game.ball.pos_x = math.random(game.window.width * 0.3, game.window.width * 0.7)
    game.ball.pos_y = math.random(game.window.height * 0.3, game.window.height * 0.7)
    game.ball.velocity.x = game.ball.pos_x >= game.window.width * 0.5 and -BALL_SPEED or BALL_SPEED
    game.ball.velocity.y = game.ball.pos_y >= game.window.height * 0.5 and -BALL_SPEED or BALL_SPEED

    game.paddles.left.pos_x = game.window.width * 0.02
    game.paddles.left.pos_y = game.window.height * 0.5 - game.paddles.left.height * 0.5
    game.paddles.right.pos_x = game.window.width * 0.98 - game.paddles.right.width
    game.paddles.right.pos_y = game.window.height * 0.5 - game.paddles.right.height * 0.5
end

function love.update(dt)
    game.ball.pos_x = game.ball.pos_x + game.ball.velocity.x * dt
    game.ball.pos_y = game.ball.pos_y + game.ball.velocity.y * dt

    game.ball.velocity.x = game.ball.velocity.x * 1.0002
    game.ball.velocity.y = game.ball.velocity.y * 1.0002

    if game.ball.pos_x - game.ball.radius <= 0 then
        game.ball.pos_x = game.ball.radius
        game.ball.velocity.x = math.abs(game.ball.velocity.x)
    elseif game.ball.pos_x + game.ball.radius >= game.window.width then
        game.ball.pos_x = game.window.width - game.ball.radius
        game.ball.velocity.x = -math.abs(game.ball.velocity.x)
    end
    
    if game.ball.pos_y - game.ball.radius <= 0 then
        game.ball.pos_y = game.ball.radius
        game.ball.velocity.y = math.abs(game.ball.velocity.y)
    elseif game.ball.pos_y + game.ball.radius >= game.window.height then
        game.ball.pos_y = game.window.height - game.ball.radius
        game.ball.velocity.y = -math.abs(game.ball.velocity.y)
    end
end

function love.draw()
    love.graphics.rectangle("fill", game.paddles.left.pos_x, game.paddles.left.pos_y, game.paddles.left.width, game.paddles.left.height)
    love.graphics.rectangle("fill", game.paddles.right.pos_x, game.paddles.right.pos_y, game.paddles.right.width, game.paddles.right.height)
    love.graphics.circle("fill", game.ball.pos_x, game.ball.pos_y, game.ball.radius)
end
