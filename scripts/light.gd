extends Node2D

@onready var lit_area: Area2D = $LitArea
@export var solid_platform_object: PackedScene
@onready var created_platforms: Node2D = $CreatedPlatforms
@onready var lit_area_collision: CollisionPolygon2D = $LitArea/CollisionPolygon2D
@onready var lit_area_visual: Polygon2D = $LitArea/Polygon2D

@export var on_immediately: bool
var on: bool = false

var global_polygon: PackedVector2Array

var starting_position: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on = on_immediately
	starting_position = global_position
	global_polygon = update_global_polygon()
	pass
	
func turn_on() -> void:
	visible = true
	lit_area.monitoring = true
	lit_area.monitorable = true
	on = true

func turn_off() -> void:
	visible = false
	lit_area.lit_platform_boxes.clear()
	global_position = Vector2(-999999, 999999)
	clear_created_platforms()
	lit_area.monitoring = false
	lit_area.monitorable = false
	on = false
	global_position = starting_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on:
		global_polygon = update_global_polygon()
		clear_created_platforms()
		solidify_platforms()
	pass
	
func clear_created_platforms() -> void:
	for child in created_platforms.get_children():
		child.queue_free()

func update_global_polygon() -> PackedVector2Array:
	var global_poly = lit_area_collision.polygon
	for n in lit_area_collision.polygon.size():
		global_poly[n] = add_rotation(global_poly[n], global_rotation) + lit_area_collision.global_position
	return global_poly
	

func solidify_platforms() -> void:
	var lit_platforms = lit_area.lit_platform_boxes
	if lit_platforms == null:
		pass
	#print("polygon before adding")
	#print(lit_polygon)
	#print("lit global position")
	#print(lit_area_collision.global_position)
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
		var intersections = Geometry2D.intersect_polygons(global_polygon, platform_shape)
		#print("Instantiating solid platforms!")
		for polygon in intersections:
			#print(polygon)
			var to_solidify_polygon = polygon.duplicate()
			for n in to_solidify_polygon.size():
				to_solidify_polygon[n] = add_rotation(to_solidify_polygon[n], -global_rotation) - add_rotation(global_position, -global_rotation)
			var to_solidify = solid_platform_object.instantiate()
			#print("light pos")
			#print(global_position)
			#to_solidify.set_global_position(global_position)
			to_solidify.set_polygon(to_solidify_polygon)
			#print(to_solidify.global_position)
			created_platforms.add_child(to_solidify)

func add_rotation(toAdd: Vector2, radians: float) -> Vector2:
	return Vector2(toAdd.x * cos(radians) - toAdd.y * sin(radians), toAdd.x * sin(radians) + toAdd.y * cos(radians))
	
