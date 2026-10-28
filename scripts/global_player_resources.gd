extends Node

signal ScoreUpdated(score:int)
signal BPMUpdated(bpm:float)

var score: int = 0
var bpm_upgrades:Array[float] = [120.0, 125.0, 130.0, 135.0, 140.0, 145.0]
var bpm_upgrade_cost:Array[int] = [10, 50, 150, 300, 500]
var bpm_level:int = 0
var sequencers:Dictionary[int,Sequencer] = {}

func _ready():
	load_game()
	auto_save()

func add_score(value:int) -> void:
	score += value
	ScoreUpdated.emit(score)

func can_buy_bpm_upgrade() -> bool:
	var cost = bpm_upgrade_cost[bpm_level]
	if score >= cost:
		return true
	return false

func buy_bpm_upgrade() -> void:
	if can_buy_bpm_upgrade():
		score -= bpm_upgrade_cost[bpm_level]
		bpm_level += 1
		BPMUpdated.emit(bpm_upgrades[bpm_level])
		ScoreUpdated.emit(score)
		

func add_sequencer(id:int, seq:Sequencer) -> void:
	sequencers[id] = seq

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
	save_dictionary["bpm_level"] = bpm_level
	
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
	bpm_level = data.get("bpm_level", 0)
	BPMUpdated.emit.call_deferred(bpm_upgrades[bpm_level])
