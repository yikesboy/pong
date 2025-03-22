BALL_RADIUS = 20
BALL_SPEED = 1000
PADDLE_HEIGHT = 150
PADDLE_WIDTH = 20
PADDLE_SPEED = 1600
STROKE_COUNT = 60

game = {
    window = {
        width = 0,
        height = 0,
        font = nil,
        color = 0,
        seperator = {
            stroke_length = 0
        },
    },
    sounds = {
        background_music = nil,
        hit_sfx = nil
    },
    players = {
        left = {
            score = 0
        },
        right = {
            score = 0
        }
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
