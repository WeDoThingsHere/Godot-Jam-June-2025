extends Node2D

@onready var collision_polygon: CollisionPolygon2D = $PlatformArea/CollisionPolygon2D
@onready var visual_polygon: Polygon2D = $PlatformArea/Bounds
@onready var fill: Polygon2D = $PlatformArea/Fill

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_collision_shape()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func set_collision_shape() -> void:
	#print("Platform Box vertices")
	collision_polygon.polygon = visual_polygon.polygon
	fill.polygon = Geometry2D.offset_polygon(visual_polygon.polygon, -0.5)[0]
	#print("collision")
	#var collision_vertices = ""
	#for vertex in collision_polygon.polygon:
		#collision_vertices += str(vertex)
	#print (collision_vertices)
	#
	#print("visual")
	#var visual_vertices = ""
	#for vertex in visual_polygon.polygon:
		#visual_vertices += str(vertex)
	#print (visual_vertices)
	#
	#print("Global position")
	#print(global_position)
	#print($PlatformArea.global_position)
