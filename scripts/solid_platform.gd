extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_polygon (polygon: PackedVector2Array) -> void:
	$StaticBody2D/Polygon2D.polygon = polygon
	$StaticBody2D/CollisionPolygon2D.polygon = polygon
	#print("Solid Platform vertices!")
	#print("Collision")
	#print($StaticBody2D/CollisionPolygon2D.polygon)
	#print("Visual")
	#print($StaticBody2D/Polygon2D.polygon)
	
	
	
