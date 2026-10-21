extends Node
class_name Sequencer

var Instrument:AudioEvents.Instrument
#Add buttons that are active

static func create_sequencer(_instrument:AudioEvents.Instrument) -> Sequencer:
	var seq = Sequencer.new()
	seq.Instrument = _instrument
	return seq
