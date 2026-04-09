extends Node

signal tilemap_bounds_changed(bounds:Array[Vector2]) 
signal level_load_started #开始加载关卡的信号
signal level_loaded       #关卡加载完成的信号

var current_tilemap_bounds:Array[Vector2] = []
var target_transition:String #目标传送位置
var position_offset:Vector2 

func update_tilemap_bounds(bounds:Array[Vector2]) -> void:
	current_tilemap_bounds = bounds
	tilemap_bounds_changed.emit(bounds)

func load_new_level(level_path:String, _target_transition:String, _position_offset:Vector2 ) -> void:
	get_tree().paused = true #tip 暂停场景
	target_transition = _target_transition
	position_offset = _position_offset

	level_load_started.emit()
	await get_tree().process_frame #tip 等待一帧的时间
	
	get_tree().change_scene_to_file(level_path)
	get_tree().paused = false
	
	await get_tree().process_frame #等待一帧的时间
	level_loaded.emit()
