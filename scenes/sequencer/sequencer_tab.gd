extends VBoxContainer
class_name Sequencer_Tab

@export var id:int = 0

@onready var instrument_picker:OptionButton = $HBoxContainer/Instrument

var model:Sequencer

func _ready():
	if id == 0:
		return

func _on_instrument_item_selected(index):
	var inst:AudioEvents.Instrument = index
	AudioEvents.UpdateInstrument.emit(id, inst)
