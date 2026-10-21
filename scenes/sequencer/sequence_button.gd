extends Button

@onready var flash:ColorRect = $Flash
@onready var score:Label = $Score

@export var step_id: int = 0
@export var pitch_value:AudioEvents.pitch = AudioEvents.pitch.C4
#@export var sequencer_tab:Sequencer_Tab

#@export var flash_color:Color = Color.ORANGE
@export var flash_duration: float = 0.25
@export var instrument:AudioEvents.Instrument = AudioEvents.Instrument.COWBELL

var _tween: Tween

var orig_score_pos
var new_score_pos

func _ready():
	AudioEvents.SendStep.connect(activate)
	AudioEvents.UpdateInstrument.connect(update_instrument)
	#flash.hide()
	var mat := flash.material as ShaderMaterial
	mat.set_shader_parameter("flash_color", AudioEvents.PITCH_COLOR[pitch_value])
	mat.set_shader_parameter("flash_amount", 0.0)
	
	score.hide()
	score.label_settings.font_color = AudioEvents.PITCH_COLOR[pitch_value]
	orig_score_pos = score.position
	new_score_pos = score.position + Vector2(score.position.x, score.position.y - 10)

func activate(step:int):
	if button_pressed and step_id == step:
		#play a sound
		AudioEvents.PlayAudio.emit(pitch_value, instrument)
		PlayerResources.add_score(1)
		flash.show()
		#await get_tree().create_timer(.25).timeout
		flash_button()
		flash_score()
		#flash.hide()

func flash_button() -> void:
	if _tween:
		_tween.kill()
	var mat := flash.material as ShaderMaterial
	mat.set_shader_parameter("flash_amount", 1.0)
	_tween = create_tween()
	_tween.tween_property(mat, "shader_parameter/flash_amount", 0.0, flash_duration)
	#_tween.tween_callback(flash.hide)

func flash_score() -> void:
	score.show()
	var tween = create_tween()
	tween.tween_property(score, "position", new_score_pos, flash_duration)
	tween.tween_callback(reset_score_pos)

func reset_score_pos() -> void:
	score.hide()
	score.position = orig_score_pos

func update_instrument(_seq_id:int, _instrument:AudioEvents.Instrument):
	var seq_tab:Sequencer_Tab = get_parent().get_parent().get_parent()
	if seq_tab and _seq_id == seq_tab.id:
		instrument = _instrument

func _process(delta):
	pass
