extends Node

signal PlayAudio(_pitch:pitch, instrument:AudioEvents.Instrument)
signal SendStep(step:int)
signal UpdateInstrument(seq_id:int, instrument:AudioEvents.Instrument)

enum Instrument{
	COWBELL,
	GUITAR,
	DRUM,
}

enum pitch{
	C4,
	CS4,
	D4,
	DS4,
	E4,
	F4,
	FS4,
	G4,
	GS4,
	A4,
	AS4,
	B4,
	C5,
}

const PITCH_COLOR = {
	pitch.C4: Color.INDIGO,
	pitch.CS4: Color.PURPLE,
	pitch.D4: Color.REBECCA_PURPLE,
	pitch.DS4: Color.BLUE_VIOLET,
	pitch.E4: Color.BLUE,
	pitch.F4: Color.NAVY_BLUE,
	pitch.FS4: Color.CADET_BLUE,
	pitch.G4: Color.SEA_GREEN,
	pitch.GS4: Color.GREEN,
	pitch.A4: Color.GREEN_YELLOW,
	pitch.AS4: Color.YELLOW,
	pitch.B4: Color.ORANGE,
	pitch.C5: Color.RED,
}
