extends VBoxContainer
class_name Sequencer_Tab

@export var id:int = 0
@export var flash_duration: float = 0.25

@onready var instrument_picker:OptionButton = $Background/HBoxContainer/Instrument
@onready var sequencer:VBoxContainer = $Sequencer
@onready var background:ColorRect = $Background

var model:Sequencer
var _tween: Tween

func _ready():
	if !model:
		model = Sequencer.create_sequencer(AudioEvents.Instrument.COWBELL)
	for row:HBoxContainer in sequencer.get_children():
		for button:SequencerButton in row.get_children():
			button.PlaySound.connect(play_audio)
	#TODO: This needs to be removed unless we always default
	if id == 0:
		return

func play_audio(pitch:AudioEvents.pitch):
	AudioEvents.PlayAudio.emit(pitch, model.Instrument)
	flash_row()

func _on_instrument_item_selected(index):
	var inst:AudioEvents.Instrument = index
	model.Instrument = inst
	#AudioEvents.UpdateInstrument.emit(id, inst)


func _on_collapse_toggled(toggled_on):
	if toggled_on:
		sequencer.hide()
	else:
		sequencer.show()

func flash_row() -> void:
	if _tween:
		_tween.kill()
	var mat := background.material as ShaderMaterial
	mat.set_shader_parameter("flash_amount", 1.0)
	_tween = create_tween()
	_tween.tween_property(mat, "shader_parameter/flash_amount", 0.0, flash_duration)
