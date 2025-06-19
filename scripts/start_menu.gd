extends Control

enum {
	LevelOne = 1,
	LevelTwo = 2,
	LevelThree = 3
	}
# Called when the node enters the scene tree for the first time.
@export_enum("LevelOne", "LevelTwo", "LevelThree")
var LevelToLoad: String = "LevelOne"

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_play_button_2_pressed() -> void:
	#print("Im being called!")
	#get_tree().change_scene_to_packed(game_scene)
	SceneManager.changeSceneTo(2)
	
