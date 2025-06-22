extends Control

enum {
	LevelOne = 1,
	LevelTwo = 2,
	LevelThree = 3
	}
# Called when the node enters the scene tree for the first time.
@export_enum("LevelOne", "LevelTwo", "LevelThree")
var LevelToLoad: String = "LevelOne"
@onready var LevelButtons = $"HBOX Level Selection Container"

#ERic's lights and platforms
@onready var platforms = $Platforms
@onready var Light2 = $Platforms/Lvl2/Light1
@onready var Light3 = $Platforms/Lvl3/Light1
@onready var Light4 = $Platforms/Lvl4/Light1
@onready var Light5 = $Platforms/Lvl5/Light1
##Lights to set visible/invisible

func showLevels() -> void:
	
	pass
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

#
#func _on_play_button_2_pressed() -> void:
	##print("Im being called!")
	##get_tree().change_scene_to_packed(game_scene)
	#SceneManager.changeSceneTo(2)
#
func setvisibility() -> void:
	if LevelButtons.visible:
		LevelButtons.visible = false
		platforms.visible = false
		Light2.visible = false
		Light3.visible = false
		Light4.visible = false
		Light5.visible = false
	else:
		LevelButtons.visible = true
		platforms.visible = true
		if (SceneManager.checkForCompletion("Level_Two")):
			Light2.visible = true
			if(SceneManager.checkForCompletion("Level_Three")):
				Light3.visible = true
				if(SceneManager.checkForCompletion("Level_Four")):
					Light4.visible = true
					if(SceneManager.checkForCompletion("Level_Five")):
						Light5.visible = true


func PlayButton() -> void:
	AudioPlayer.play_UI()
	setvisibility()
	


func _on_quit_button_pressed() -> void:
	get_tree().quit() # Replace with function body.
