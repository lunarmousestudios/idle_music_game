extends Control

@onready var audio_streams: Array[AudioStreamPlayer2D] = [$Stream1, $Stream2, $Stream3, $Stream4, $Stream5, $Stream6, $Stream7, $Stream8, $Stream9, $Stream10, $Stream11, $Stream12, $Stream13, $Stream14, $Stream15, $Stream16]

@onready var cowbell: AudioStream = load("res://assets/audio/instruments/cowbell__1_forte_undamped.mp3")
@onready var guitar: AudioStream = load("res://assets/audio/instruments/guitar_C4_very-long_forte_normal.mp3")

var cur_stream = 0

func _ready():
	AudioEvents.PlayAudio.connect(PlayAudio)

func PlayAudio(pitch:AudioEvents.pitch, instrument:AudioEvents.Instrument):
	var stream = audio_streams[cur_stream]
	cur_stream = (cur_stream + 1) % audio_streams.size()
	stream.pitch_scale = pow(2.0, pitch / 12.0)
	stream.stream = get_instrument(instrument)
	stream.play()

func get_instrument(instrument:AudioEvents.Instrument) -> AudioStream:
	match instrument:
		AudioEvents.Instrument.COWBELL:
			return cowbell
		AudioEvents.Instrument.GUITAR:
			return guitar
	return cowbell
