extends CanvasLayer

@export var bpm = 120.0
@export var step = 0
@export var total_steps = 16

@onready var beat_time: Timer = $Beat
@onready var score_label: Label = $Resources/Resources/Score
@onready var bpm_label: Label = $Resources/Resources/BPM
@onready var bpm_upgrade_btn: Button = $UpgradeBPM

func _ready():
	start_sequencer()
	PlayerResources.ScoreUpdated.connect(update_score)
	PlayerResources.BPMUpdated.connect(update_sequencer)
	update_score(0)

func start_sequencer() -> void:
	var step_druation = (60.0/bpm) / 4.0
	beat_time.wait_time = step_druation
	beat_time.start()

func _on_beat_timeout():
	AudioEvents.SendStep.emit(step)
	step = (step + 1) % total_steps

func update_sequencer(_bpm:float):
	bpm = _bpm
	update_bpm()
	beat_time.stop()
	start_sequencer()

func update_score(score:int) -> void:
	if PlayerResources.can_buy_bpm_upgrade():
		bpm_upgrade_btn.show()
	else:
		bpm_upgrade_btn.hide()
	score_label.text = "Score: " + str(score)

func update_bpm() -> void:
	bpm_label.text = "BPM: " + str(bpm)
	


func _on_upgrade_bpm_pressed():
	PlayerResources.buy_bpm_upgrade()
