extends KinematicBody2D


const UP = Vector2(0, -1)
const FLAP = 200
const MAXFALLSPEED = 200
const GRAVITY = 10

var Alive = true
var motion = Vector2()
var Wall = preload("res://Scenes/Wallnode.tscn")
const GameOver = preload("res://Scenes/UI/GameOverLevel.tscn")
const PauseScreen = preload("res://Scenes/UI/PauseScreen.tscn")
var Sprites = ["Yellow", "Green", "Red", "Blue", "Pink", "Rabbit"]


func _ready():
	var config = ConfigFile.new()
	var err = config.load("user://config.cfg")
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
		
	if get_global_position()[1] > 230:
		die(false)
	
	if Input.is_action_just_pressed("FLAP"):
		motion.y = -FLAP
		motion.x = 0
	
	motion = move_and_slide(motion, UP)



func _on_Detect_area_entered(area):
	print(area.name)
	if area.name == "PointArea":
		$soundPoint.play()
	if area.name == "Finish":
		win()
		
			
func die(playSound: bool):
	if Alive:
		Alive = false
		if playSound:
			$soundHit.play()
		yield(get_tree().create_timer(0.55), "timeout")
		var game_over = GameOver.instance()
		add_child(game_over)
		game_over.set_title(false)

func win():
	var game_over = GameOver.instance()
	add_child(game_over)
	game_over.set_title(true)
		
func _on_Detect_body_entered(body):
	if body.name == "Walls":
		die(true)

func _unhandled_input(event):
	if event.is_action_pressed('pause'):
		var pause_menu = PauseScreen.instance()
		add_child(pause_menu)
		
