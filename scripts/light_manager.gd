extends Node2D

@onready var mask: SubViewport = $LightMask

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mask.size = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
