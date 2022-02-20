extends KinematicBody2D


const UP = Vector2(0, -1)
const FLAP = 200
const MAXFALLSPEED = 200
const GRAVITY = 10

var Alive = true
var motion = Vector2()
var Wall = preload("res://Scenes/Wallnode.tscn")
const GameOver = preload("res://Scenes/UI/GameOver.tscn")
const PauseScreen = preload("res://Scenes/UI/PauseScreen.tscn")
var Sprites = ["Yellow", "Green", "Red", "Blue", "Pink", "Rabbit"]

var score = 0

func _ready():
	var config = ConfigFile.new()
	var err = config.load("user://config.cfg")
	var highScore = config.get_value("Player", "HighScore")
	var masterVolume = config.get_value("Options", "Sound")
	var SpriteNumber = config.get_value("Player", "Sprite")
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), masterVolume)
	
	show_sprite(SpriteNumber)
	
	
func show_sprite(spriteNumber):
	$Yellow.visible = false
	$Green.visible = false
	$Red.visible = false
	$Blue.visible = false
	$Pink.visible = false
	
	var spriteName = Sprites[spriteNumber]
	get_node(spriteName).visible = true

func _physics_process(delta):
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
		
	if get_global_position()[1] > 175:
		motion.y = 0
		die()
	
	if Input.is_action_just_pressed("CLICK"):
		motion.y = -FLAP
		motion.x = 0
	
	motion = move_and_slide(motion, UP)
	
#func Floor_reset():
	#var Floor_instance = 
func Wall_reset():
	var Wall_instance = Wall.instance()
	Wall_instance.position = Vector2(450, rand_range(-90, 90))
	get_parent().call_deferred("add_child", Wall_instance)
	
func _on_Resetter_body_entered(body):
	if body.name == "Walls":
		body.queue_free()
		Wall_reset()


func _on_Detect_area_entered(area):
	var config = ConfigFile.new()
	var err = config.load("user://config.cfg")
	var highScore = config.get_value("Player", "HighScore")
	
	if area.name == "PointArea":
		$soundPoint.play()
		score += 1
		get_parent().get_parent().get_node("CanvasLayer/CurrentScore2").text = str(score)
		if score > highScore:
			highScore = score
			print(highScore)
			config.set_value("Player", "HighScore", highScore)
			config.save("user://config.cfg")
			get_parent().get_parent().get_node("CanvasLayer/HighScore").text = str(highScore)
		
			
func die():
	if Alive:
		Alive = false
		$soundHit.play()
		yield(get_tree().create_timer(0.55), "timeout")
		var game_over = GameOver.instance()
		add_child(game_over)
		game_over.set_title(score)

func _on_Detect_body_entered(body):
	if body.name == "Walls":
		die()

func _unhandled_input(event):
	if event.is_action_pressed('pause'):
		var pause_menu = PauseScreen.instance()
		add_child(pause_menu)
		
