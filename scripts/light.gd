extends Node2D

@onready var lit_area: Area2D = $LitArea
@export var solid_platform_object: PackedScene
@onready var created_platforms: Node2D = $CreatedPlatforms
@onready var lit_area_collision: CollisionPolygon2D = $LitArea/CollisionPolygon2D
@onready var lit_area_visual: Polygon2D = $LitArea/Polygon2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	clear_created_platforms()
	solidify_platforms()
	pass
	
func clear_created_platforms() -> void:
	for child in created_platforms.get_children():
		child.queue_free()

func solidify_platforms() -> void:
	var lit_platforms = lit_area.lit_platform_boxes
	if lit_platforms == null:
		pass
	
	var lit_polygon = lit_area_collision.polygon
	#print("polygon before adding")
	#print(lit_polygon)
	#print("lit global position")
	#print(lit_area_collision.global_position)
	for n in lit_polygon.size():
		#print(rotation)
		lit_polygon[n] =  add_rotation(lit_polygon[n], rotation) + lit_area_collision.global_position
	for platform in lit_platforms:
		var platform_shape = lit_platforms[platform].duplicate()
		for n in platform_shape.size():
				platform_shape[n] = platform_shape[n] + platform.global_position
		#print("platform area global position")
		#print(platform.global_position)
		#print("lit area in global space")
		#print(lit_polygon)
		#print("platform polygon in global space")
		#print(platform_shape)
		var intersections = Geometry2D.intersect_polygons(lit_polygon, platform_shape)
		#print("Instantiating solid platforms!")
		for polygon in intersections:
			#print(polygon)
			var to_solidify_polygon = polygon.duplicate()
			for n in to_solidify_polygon.size():
				to_solidify_polygon[n] = add_rotation(to_solidify_polygon[n], -rotation) - add_rotation(lit_area_collision.global_position, -rotation)
			var to_solidify = solid_platform_object.instantiate()
			#print("light pos")
			#print(global_position)
			#to_solidify.set_global_position(global_position)
			to_solidify.set_polygon(to_solidify_polygon)
			#print(to_solidify.global_position)
			created_platforms.add_child(to_solidify)

func add_rotation(toAdd: Vector2, radians: float) -> Vector2:
	return Vector2(toAdd.x * cos(radians) - toAdd.y * sin(radians), toAdd.x * sin(radians) + toAdd.y * cos(radians))
	
