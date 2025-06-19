extends Node2D

@onready var shadow_area: Area2D = $ShadowArea
@onready var shadow_polygon: Polygon2D = $ShadowPolygon
var starting_polygon
var global_polygon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shadow_polygon.polygon = shadow_area.collision_polygon.polygon
	starting_polygon = shadow_polygon.polygon
	print("Shadow polygon:")
	print(shadow_polygon.polygon)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	cutout_lights()
	pass
		
func update_global_polygon() -> PackedVector2Array:
	var global_poly = shadow_polygon.polygon
	for n in shadow_polygon.polygon.size():
		global_poly[n] = add_rotation(global_poly[n], global_rotation) + shadow_polygon.global_position
	return global_poly

func cutout_lights() -> void:
	var lights = shadow_area.light_polygons
	shadow_polygon.polygon = starting_polygon
	print("Number of lights:")
	print(lights.size())
	for area in lights:
		var light_polygon = area.update_global_polygon()
		var cutout = Geometry2D.clip_polygons(shadow_polygon.polygon, area.update_global_polygon())
		print("CURRENT LIGHT POLYGON")
		print(light_polygon)
		print("CUTTOUT:")
		print(cutout[0])
		shadow_polygon.polygon = cutout[0]
		
func add_rotation(toAdd: Vector2, radians: float) -> Vector2:
	return Vector2(toAdd.x * cos(radians) - toAdd.y * sin(radians), toAdd.x * sin(radians) + toAdd.y * cos(radians))
