extends CanvasLayer

var config = ConfigFile.new()
var err = config.load("user://config.cfg")
var masterVolume = config.get_value("Options", "Sound")
var spriteNumber = config.get_value("Player", "Sprite")
var Sprites = ["Yellow", "Green", "Red", "Blue", "Pink"]

#Sound
onready var MasterVolumeAmount = $SettingTabs/Audio/MarginContainer/AudioSettings/HBoxContainer/HBoxContainer/VolumeAmount
onready var MasterVolumeSlider = $SettingTabs/Audio/MarginContainer/AudioSettings/HBoxContainer/HBoxContainer/MasterSlider
onready var SpriteSlider = $SettingTabs/GamePlay/MarginContainer3/GameplaySettings/Collumn/SpriteSlider

func _ready():
	var volumePercent = masterVolume*2+100
	if volumePercent == -100:
		volumePercent = 0
	if len(str(volumePercent)) == 1:
		MasterVolumeAmount.text = "  " + str(volumePercent) + "%"
	elif len(str(volumePercent)) == 2:
		MasterVolumeAmount.text = " " + str(volumePercent) + "%"
	else:
		MasterVolumeAmount.text = str(volumePercent) + "%"
	
	MasterVolumeSlider.value = masterVolume
	SpriteSlider.value = spriteNumber
	show_sprite(spriteNumber)

func _on_MasterSlider_value_changed(masterVolume):
	var volumePercent = masterVolume*2+100
	if len(str(volumePercent)) == 1:
		MasterVolumeAmount.text = "  " + str(volumePercent) + "%"
	elif len(str(volumePercent)) == 2:
		MasterVolumeAmount.text = " " + str(volumePercent) + "%"
	else:
		MasterVolumeAmount.text = str(volumePercent) + "%"
	if masterVolume == -50:
		config.set_value("Options", "Sound", -100)
	else:
		config.set_value("Options", "Sound", masterVolume)


func _on_SpriteSlider_value_changed(spriteNumber):
	show_sprite(spriteNumber)
	config.set_value("Player", "Sprite", spriteNumber)

func show_sprite(spriteNumber):
	$SettingTabs/GamePlay/MarginContainer3/GameplaySettings/Collumn/Yellow.visible = false
	$SettingTabs/GamePlay/MarginContainer3/GameplaySettings/Collumn/Green.visible = false
	$SettingTabs/GamePlay/MarginContainer3/GameplaySettings/Collumn/Red.visible = false
	$SettingTabs/GamePlay/MarginContainer3/GameplaySettings/Collumn/Blue.visible = false
	$SettingTabs/GamePlay/MarginContainer3/GameplaySettings/Collumn/Pink.visible = false
	
	var spriteName = Sprites[spriteNumber]
	print(spriteName)
	get_node("SettingTabs/GamePlay/MarginContainer3/GameplaySettings/Collumn/" + spriteName).visible = true

func _on_Save_pressed():
	config.save("user://config.cfg")
	get_tree().change_scene("res://Scenes/UI/MainMenu.tscn")




