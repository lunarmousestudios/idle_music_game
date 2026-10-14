extends CanvasLayer

@export var bpm = 120.0
@export var step = 0
@export var total_steps = 16

@onready var beat_time: Timer = $Beat
@onready var score_label: Label = $Score

func _ready():
	start_sequencer()
	PlayerResources.ScoreUpdated.connect(update_score)
	update_score(0)

func start_sequencer() -> void:
	var step_druation = (60.0/bpm) / 4.0
	beat_time.wait_time = step_druation
	beat_time.start()

func _on_beat_timeout():
	AudioEvents.SendStep.emit(step)
	step = (step + 1) % total_steps

func update_score(score:int) -> void:
	score_label.text = "Score: " + str(score)
	
