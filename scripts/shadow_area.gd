extends Area2D

var light_polygons: Dictionary[Area2D, PackedVector2Array] = {}
@onready var collision_polygon: CollisionPolygon2D = $CollisionPolygon2D
@onready var visual_polygon: Polygon2D = $Polygon2D

func _ready() -> void:
	set_collision_shape()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("lights"):
		print("AREA IS IN LIGHTS!");
		var polygon = area.get_node_or_null("CollisionPolygon2D")
		if polygon:
			light_polygons[area] = polygon.polygon
			print("Gotten platform vertices")
			print(light_polygons[area])
		else:
			print("Whoops no polygon collider on this area even tho it rly should have one since it's a platform box")


func _on_area_exited(area: Area2D) -> void:
	print("Something exited!")
	light_polygons.erase(area)

func set_collision_shape() -> void:
	collision_polygon.polygon = visual_polygon.polygon
	collision_polygon.global_position = visual_polygon.global_position
	visual_polygon.visible = false
	print("Shadow Area Visual Polygon:")
	print(visual_polygon.polygon)
	print("Shadow Area Collision Polygon:")
	print(collision_polygon.polygon)
