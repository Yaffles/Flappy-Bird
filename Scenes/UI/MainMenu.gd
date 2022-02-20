extends CanvasLayer

var config = ConfigFile.new()
var err = config.load("user://config.cfg")
var spriteNumber = config.get_value("Player", "Sprite")
var Sprites = ["Yellow", "Green", "Red", "Blue", "Pink", "Rabbit"]

func _ready():
	show_sprite()
	
func show_sprite():
	$"../Yellow".visible = false
	$"../Green".visible = false
	$"../Red".visible = false
	$"../Blue".visible = false
	$"../Pink".visible = false
	
	var spriteName = Sprites[spriteNumber]
	get_node("../" + spriteName).visible = true

func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/Levels/Level_1.tscn")

func _on_Quit_Button_pressed():
	get_tree().quit()


func _on_OptionsButton_pressed():
	get_tree().change_scene("res://Scenes/UI/OptionsMenu.tscn")


func _on_SpriteButton_pressed():
	print("button")
	get_tree().change_scene("res://Scenes/UI/ChangeSpriteScreen.tscn")


func _on_InfiniteButton_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")
