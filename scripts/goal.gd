extends Area2D

enum Levels{
	LevelOne = 1,
	LevelTwo = 2,
	LevelThree = 3
	}
# Called when the node enters the scene tree for the first time.
@export_enum("Level_One", "Level_Two", "Level_Three", "Level_Four", "Level_Five")
var Level_To_Unlock: String = "LevelTwo" #level to unlock
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func onCollision(body: Node2D) -> void:
	print("Goal was reached! Now checking if it is a player")
	if body.is_in_group("Player"):
		print("Goal reached by player!")
		SceneManager.changeCompletionStatus(Level_To_Unlock)
		get_parent().get_node("EveryGameScene/Control/Completion").visible = true
		#SceneManager.changeSceneTo()
	pass # Replace with function body.
