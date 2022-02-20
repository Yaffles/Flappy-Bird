extends CanvasLayer


const borderCoords = {"Yellow":[576, 441],"Green":[884, 441],"Red":[1192, 441],"Blue":[576, 678],"Pink":[884, 678],"Rabbit":[1192, 678]}
const Sprites = ["Yellow", "Green", "Red", "Blue", "Pink", "Rabbit"]


var config = ConfigFile.new()
var err = config.load("user://config.cfg")

var spriteNumber = config.get_value("Player", "Sprite")




func _ready():
	$Border.set_position(Vector2(borderCoords[Sprites[spriteNumber]][0],borderCoords[Sprites[spriteNumber]][1]))

func Select_Sprite(spriteNumber):
	var spriteName = Sprites[spriteNumber]
	$Border.set_position(Vector2(borderCoords[spriteName][0],borderCoords[spriteName][1]))
	config.set_value("Player", "Sprite", spriteNumber)


func _on_Yellow_pressed():
	Select_Sprite(0)

func _on_Green_pressed():
	Select_Sprite(1)

func _on_Red_pressed():
	Select_Sprite(2)

func _on_Blue_pressed():
	Select_Sprite(3)

func _on_Pink_pressed():
	Select_Sprite(4)

func _on_Rabbit_pressed():
	Select_Sprite(5)



func _on_Save_pressed():
	config.save("user://config.cfg")
	get_tree().change_scene("res://Scenes/UI/MainMenu.tscn")
