extends Node2D
@onready var sprite: Sprite2D = $Sprite2D
var spawn_x_min: float
var spawn_x_max: float
var spawn_y_min: float
var spawn_y_max: float
var direction: Vector2
var alpha: float
var size: float


func _physics_process(delta: float) -> void:
#	Have the particle drift in random directions.
	pass

func spawn(min: Vector2, max: Vector2, dir: Vector2, a: float, s: float) -> void:
	spawn_x_min = min.x
	spawn_y_min = min.y
	spawn_x_max = max.x
	spawn_y_max = max.y
	direction = dir
	alpha = a
	size = s
