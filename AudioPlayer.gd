extends Node2D

@onready var music =$"Music Player"
@onready var sfx = $"Death Sound"
@onready var uisfx = $"UI Sound"

func play_music():
	music.play()

func stop_music():
	music.stop()

func play_death():
	sfx.play()

func play_UI():
	uisfx.play()
	
func _ready() -> void:
	play_music()
