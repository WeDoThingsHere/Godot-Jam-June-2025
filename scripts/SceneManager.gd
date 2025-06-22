extends Node

var loadedLevel = {
	"Level_One": preload("res://scenes/Levels/001_LevelOne.tscn"),
	"Level_Two": preload("res://scenes/Levels/002_LevelTwo.tscn"),
	"Level_Three": preload("res://scenes/Levels/003_LevelThree.tscn"),
	"Level_Four": preload("res://scenes/Levels/004_LevelFour.tscn"),
	"Level_Five": preload("res://scenes/Levels/005_LevelFive.tscn")
}
var completation = {
	"Level_One": true,
	"Level_Two": false,
	"Level_Three": false,
	"Level_Four": false,
	"Level_Five": false,
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func changeCompletionStatus(Level: String) -> void:
	if completation.has(Level):
		completation[Level] = true
	else:
		print(Level, "does not exist.")

		
func checkForCompletion(Level: String) -> bool:
	if completation.has(Level):
		print(Level, "exists!")
		return completation[Level]
	else:
		print(Level, "does not exist.")
		return false
	
func changeSceneTo(scene: String) -> void:
	if completation.has(scene):
		print(scene, "exists!")
		get_tree().change_scene_to_packed(loadedLevel[scene])
	else:
		print(scene, "does not exist.")
		
	##
	#match scene:
		#1:
			#get_tree().change_scene_to_packed(loadedLevel["Level_One"])
		#2:
			#get_tree().change_scene_to_packed(loadedLevel["Level_Two"])
		#3:
			#get_tree().change_scene_to_packed(loadedLevel["Level_Three"])
		#_:
			#print("Not a valid int or scene, the number was ", scene, ".");
	#
