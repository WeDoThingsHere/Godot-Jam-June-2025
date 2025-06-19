extends Node2D

@onready var light: Node2D = $Light
@onready var timer: Timer = $Timer
@export var loop: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	print("FLICKER FLICKER")
	if light.on:
		light.turn_off()
	else:
		light.turn_on()
