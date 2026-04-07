extends TileMapLayer
class_name LevelTileMap


func _ready() -> void:
	GlobalLevelManager.update_tilemap_bounds(get_tilemap_bounds())
	
func get_tilemap_bounds() -> Array[Vector2]:
	var bounds:Array[Vector2] = []
	bounds.append(
		Vector2(get_used_rect().position * rendering_quadrant_size) #tip 获取渲染区域左上角
	)
	bounds.append(
		Vector2(get_used_rect().end * rendering_quadrant_size)
	)
	return bounds
