extends Control

var game_scene = preload("res://scenes/platform_test.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_play_button_2_pressed() -> void:
	#print("Im being called!")
	get_tree().change_scene_to_packed(game_scene)
	
