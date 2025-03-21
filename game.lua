BALL_RADIUS = 20
BALL_SPEED = 1000
PADDLE_HEIGHT = 150
PADDLE_WIDTH = 20
PADDLE_SPEED = 1400

game = {
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
