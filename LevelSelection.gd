extends Button

enum Levels{
	LevelOne = 1,
	LevelTwo = 2,
	LevelThree = 3
	}
# Called when the node enters the scene tree for the first time.
@export_enum("Level_One", "Level_Two", "Level_Three", "Level_Four", "Level_Five")
var LevelToLoad: String = "Level_One"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func OnPress() -> void:
	print("ON BUTTON PRESS: Attempting to load " + LevelToLoad)
	#Checking if player meets the prereqs.
	if(SceneManager.checkForCompletion(LevelToLoad)):
		SceneManager.changeSceneTo(LevelToLoad)
	else:
		print("LevelSelection: The level" + LevelToLoad + "DNE or the player cannot access this level yet!")
		
	#SceneManager.changeSceneTo(LevelToLoad)
	pass # Replace with function body.
