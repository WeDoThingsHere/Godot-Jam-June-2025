extends Node2D

@onready var bounds_polygon: Polygon2D = $StaticBody2D/bounds
@onready var collision_polygon: CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D
@onready var fill_polygon: Polygon2D = $StaticBody2D/fill

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_polygon()


func set_polygon () -> void:
	collision_polygon.polygon = bounds_polygon.polygon
	var outline = Geometry2D.offset_polygon(bounds_polygon.polygon, -3)
	if outline.size() > 0:
		fill_polygon.polygon = outline[0]
