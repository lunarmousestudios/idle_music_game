extends Button

@onready var flash:ColorRect = $Flash

@export var step_id: int = 0
@export var pitch_value:AudioEvents.pitch = AudioEvents.pitch.C4

func _ready():
	AudioEvents.SendStep.connect(activate)
	flash.hide()

func activate(step:int):
	if button_pressed and step_id == step:
		#play a sound
		AudioEvents.PlayAudio.emit(pitch_value)
		PlayerResources.add_score(1)
		flash.show()
		await get_tree().create_timer(.25).timeout
		flash.hide()


func _process(delta):
	pass
