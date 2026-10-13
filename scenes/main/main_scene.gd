extends CanvasLayer

@onready var label: Label = $Label

var presses = 0

func _ready():
	label.text = "Score: " + str(presses)

func _on_button_pressed():
	presses += 1
	label.text = "Score: " + str(presses)
