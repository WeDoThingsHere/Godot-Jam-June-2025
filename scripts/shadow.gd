extends Node2D

@onready var shadow_area: Area2D = $ShadowArea
@onready var shadow_polygon: Polygon2D = $ShadowPolygon
var starting_polygon
var global_polygon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shadow_polygon.polygon = shadow_area.collision_polygon.polygon
	starting_polygon = shadow_polygon.polygon
	global_polygon = update_global_polygon(starting_polygon)
	print("Shadow polygon:")
	print(shadow_polygon.polygon)
	print("Global Polygon:")
	print(global_polygon)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cutout_lights()
	pass
		
func update_global_polygon(poly: PackedVector2Array) -> PackedVector2Array:
	var global_poly = poly
	for n in poly.size():
		global_poly[n] = add_rotation(global_poly[n], global_rotation) + global_position
	return global_poly

func cutout_lights() -> void:
	var lights = shadow_area.light_polygons
	var pending_polygon = global_polygon
	shadow_polygon.polygon = starting_polygon
	
	print("Number of lights:")
	print(lights.size())
	for area in lights:
		var light_polygon = area.update_global_polygon()
		var cutouts = Geometry2D.clip_polygons(pending_polygon, light_polygon)
		var cutout: PackedVector2Array
		if cutouts.size() == 0: 
			continue
		if cutouts.size() > 1:
			print("We got more than one cutout:")
			for n in cutouts.size():
				if Geometry2D.is_polygon_clockwise(cutouts[n]):
					print("This cutout is clockwise!")
					cutout = cutouts[n].duplicate()
				else:
					print("This cutout is counterclockwise!")
				print(cutouts[n])
		elif cutouts.size() == 1:
			cutout = cutouts[0].duplicate()
		
		#for n in cutout.size():
			#cutout[n] = cutout[n] - global_position
		print("CURRENT LIGHT POLYGON")
		print(light_polygon)
		#print("CUTTOUT:")
		#print(cutout)
		pending_polygon.add_outline(cutout)
		
	for n in pending_polygon.size():
		pending_polygon[n] = pending_polygon[n] - global_position
	shadow_polygon.polygon = pending_polygon
	
func add_rotation(toAdd: Vector2, radians: float) -> Vector2:
	return Vector2(toAdd.x * cos(radians) - toAdd.y * sin(radians), toAdd.x * sin(radians) + toAdd.y * cos(radians))
