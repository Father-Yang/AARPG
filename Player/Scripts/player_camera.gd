extends Camera2D
class_name PlayerCamera

func _ready() -> void:
	GlobalLevelManager.tilemap_bounds_changed.connect(on_update_limits)
	on_update_limits(GlobalLevelManager.current_tilemap_bounds) #tip 先执行一次

func on_update_limits(bounds:Array[Vector2]) -> void:
	if bounds.size() != 2: return 
	limit_left = int(bounds[0].x)
	limit_top = int(bounds[0].y)
	limit_right = int(bounds[1].x)
	limit_bottom = int(bounds[1].y)
