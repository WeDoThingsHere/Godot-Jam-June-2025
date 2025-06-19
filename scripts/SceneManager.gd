extends Node

var levels = {
	"Level_One": preload("res://scenes/platform_test.tscn"),
	"Level_Two": preload("res://scenes/platform_test.tscn"),
	"Level_Three": preload("res://scenes/platform_test.tscn"),
}
static var completation = {
	"Level_One": true,
	"Level_Two": false,
	"Level_Three": false,
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func changeSceneTo(scene: int) -> void:
	match scene:
		1:
			get_tree().change_scene_to_packed(levels["Level_One"])
		2:
			get_tree().change_scene_to_packed(levels["Level_Two"])
		3:
			get_tree().change_scene_to_packed(levels["Level_Three"])
		_:
			print("Not a valid int or scene, the number was ", scene, ".");
# Called every frame. 'delta' is the elapsed time since the previous frame.
