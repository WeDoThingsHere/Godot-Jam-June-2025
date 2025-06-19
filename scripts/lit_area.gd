extends Area2D

var lit_platform_boxes: Dictionary[Area2D, PackedVector2Array] = {}
@onready var visual_polygon: Polygon2D = $Polygon2D
@onready var collision_polygon: CollisionPolygon2D = $CollisionPolygon2D

var global_polygon: PackedVector2Array


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_collision_shape()
	#visual_polygon.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_global_polygon() -> PackedVector2Array:
	var global_poly = collision_polygon.polygon
	for n in collision_polygon.polygon.size():
		global_poly[n] = (add_rotation(global_poly[n], global_rotation) + collision_polygon.global_position) * global_scale
	return global_poly

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("platforms"):
		#print("AREA IS IN GROUP!");
		var polygon = area.get_node_or_null("CollisionPolygon2D")
		if polygon:
			lit_platform_boxes[area] = polygon.polygon.duplicate()
			#print("Gotten platform vertices")
			#print(lit_platform_boxes[area])
		else:
			print("Whoops no polygon collider on this area even tho it rly should have one since it's a platform box")


func _on_area_exited(area: Area2D) -> void:
	lit_platform_boxes.erase(area)

func set_collision_shape() -> void:
	#print("Lit_area vertices")
	#print("collision")
	#print(visual_polygon.polygon)
	collision_polygon.polygon = visual_polygon.polygon
	collision_polygon.global_position = visual_polygon.global_position
	#print(collision_polygon.polygon)
	
	#var collision_vertices = ""
	#for vertex in collision_polygon.polygon:
		#collision_vertices += str(vertex)
	#print (collision_vertices)
	#print("visual")
	#var visual_vertices = ""
	#for vertex in visual_polygon.polygon:
		#visual_vertices += str(vertex)
	#print (visual_vertices)

func add_rotation(toAdd: Vector2, radians: float) -> Vector2:
	return Vector2(toAdd.x * cos(radians) - toAdd.y * sin(radians), toAdd.x * sin(radians) + toAdd.y * cos(radians))
