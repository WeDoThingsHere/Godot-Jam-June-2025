extends Control

var startMenuScene = preload("res://scenes/Levels/start_menu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		print("Pause key pressed")
		toggle_pause()
		
func toggle_pause():
	if Engine.time_scale == 1.0:
		pause_game()
	else:
		resume_game()
		
func pause_game():
	Engine.time_scale = 0.0
	visible = true

func resume_game():
	Engine.time_scale = 1.0
	visible = false


func _on_resume_pressed() -> void:
	AudioPlayer.play_UI()
	resume_game()



func _on_quit_pressed() -> void:
	AudioPlayer.play_UI()
	get_tree().quit()


func _on_start_menu_pressed() -> void:
	AudioPlayer.play_UI()
	Engine.time_scale = 1.0
	get_tree().change_scene_to_packed(startMenuScene)
