extends CanvasLayer


onready var title = $PanelContainer/MarginContainer/Rows/WinLoss

func _ready():
	get_tree().paused = true


func set_title(win):
	if win:
		title.text = "You Won!"
	else:
		title.add_color_override("font_color", ColorN("red", 1))
		title.text = "You Lost"

func _on_RestartButton_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_Quit_Button_pressed():
	get_tree().quit()


func _on_MainMenuButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/UI/MainMenu.tscn")
