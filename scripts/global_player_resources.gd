extends Node

signal ScoreUpdated(score:int)

var score: int = 0

func _ready():
	load_game()
	auto_save()

func add_score(value:int) -> void:
	score += value
	ScoreUpdated.emit(score)


func auto_save():
	await get_tree().create_timer(30).timeout
	save_game()

const SAVE_PATH = "user://save_data.json"

func save_game() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if not file:
		push_error("failed to save")
		return
	
	var save_dictionary: Dictionary = {}
	save_dictionary["score"] = score
	
	var json_string = JSON.stringify(save_dictionary, "\t")
	file.store_string(json_string)
	file.close()
	print("game saved")

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		print("file not found")
		return
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		push_error("Failed to read")
		return
	
	var contents = file.get_as_text()
	file.close()
	
	var data:Dictionary = JSON.parse_string(contents)
	if not data:
		push_error("data failed")
		return
	
	score = data.get("score", 0)
	ScoreUpdated.emit.call_deferred(score)
