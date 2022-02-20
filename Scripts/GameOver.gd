extends CanvasLayer

const KEY = "key1Fc9gHxOAsHqpw"
const SITE = "https://api.airtable.com/v0/appFU9w2cQQjEI8er/"

onready var title = $PanelContainer/MarginContainer/Rows/Score

func _ready():
	print("a")
	var config = ConfigFile.new()
	config.load("user://config.cfg")
	var highScore = config.get_value("Player", "HighScore")
	
	$PanelContainer/MarginContainer/Rows/highScore.text = "High Score: " + str(highScore)
	
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_http_request_completed")
	
	http_request.request(SITE + "Table%201", ["Authorization:Bearer " + KEY])
	
	get_tree().paused = true

func _http_request_completed(result, response_code, headers, body):
	print(parse_json(body.get_string_from_utf8()))
	var response = parse_json(body.get_string_from_utf8())
	if "records" in response:
		var worldRecord = response["records"][0]["fields"]["Value"]
		$PanelContainer/MarginContainer/Rows/worldRecord.text = "World Record: " + worldRecord
		
		var config = ConfigFile.new()
		config.load("user://config.cfg")
		var highScore = config.get_value("Player", "HighScore")

		var data = '{"fields": {"Key": "WorldRecord","Value": "' + str(highScore) + '"}}'
		
		if highScore > int(worldRecord):
			var http_request = HTTPRequest.new()
			add_child(http_request)
			http_request.connect("request_completed", self, "_http_request_completed")
			
			http_request.request("https://api.airtable.com/v0/appFU9w2cQQjEI8er/Table%201/recoPtzyvIUYdEr2a", ["Authorization:Bearer " + KEY, "Content-Type:application/json"], true, HTTPClient.METHOD_PATCH, str(data))
	else:
		var http_request = HTTPRequest.new()
		add_child(http_request)
		http_request.connect("request_completed", self, "_http_request_completed")
	
		http_request.request(SITE + "Table%201", ["Authorization:Bearer " + KEY])
	
func set_title(score: int):
	title.text = str(score)

func _on_RestartButton_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_Quit_Button_pressed():
	get_tree().quit()


func _on_MainMenuButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/UI/MainMenu.tscn")
