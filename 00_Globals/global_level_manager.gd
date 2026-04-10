extends Node

signal tilemap_bounds_changed(bounds:Array[Vector2]) 
signal level_load_started #开始加载关卡的信号
signal level_loaded       #关卡加载完成的信号

var current_tilemap_bounds:Array[Vector2] = []
var target_transition:String #目标传送位置
var position_offset:Vector2 

func _ready() -> void:
	await get_tree().process_frame #起始帧处理完成
	level_loaded.emit()

func update_tilemap_bounds(bounds:Array[Vector2]) -> void:
	current_tilemap_bounds = bounds
	tilemap_bounds_changed.emit(bounds)

func load_new_level(level_path:String, _target_transition:String, _position_offset:Vector2 ) -> void:
	get_tree().paused = true #tip 暂停场景
	target_transition = _target_transition
	position_offset = _position_offset
	
	await SceneTransition.fade_out() #淡出场景 SceneTransition场景需要修改状态 不然会继承上面的暂停
	level_load_started.emit()
	await get_tree().process_frame #tip 等待一帧的时间
	get_tree().change_scene_to_file(level_path)
	
	await SceneTransition.fade_in() #淡入场景
	get_tree().paused = false
	await get_tree().process_frame #等待一帧的时间
	level_loaded.emit()
