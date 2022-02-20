extends StaticBody2D

var y = round(rand_range(0,1))
var ySpeed = 0
var MOVE = round(rand_range(0,3))
const xSpeed = -2

func _ready():
	if MOVE == 0:
		ySpeed = rand_range(0.1, 0.5)

func _physics_process(_delta):
	if MOVE == 0:
		if y > 0:
			if y < 100:
				position += Vector2(xSpeed, ySpeed)
				y += 1
			else:
				y = -1
		else:
			if y > -100:
				position += Vector2(xSpeed, -ySpeed)
				y -= 1
			else:
				y = 1
	else:
		position += Vector2(xSpeed, 0)
