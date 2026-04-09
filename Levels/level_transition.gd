@tool #tip
extends Area2D
class_name LevelTransition

enum SIDE {UP, DOWN, LEFT, RIGHT}

#tip resource_local_to_scene 这个属性需要启用，场景本地化设置

# 需要按照下面的参数，将碰撞区域扩大覆盖通道口
@export_file("*.tscn") var level
@export var target_transition_area:String = "LevelTransition"
@export_category("碰撞体设置")
@export_range(1,12,1,"or_greater") var size:int = 2:
	set(_v):
		size = _v
		_update_area()
@export var side:SIDE = SIDE.UP:
	set(_v):
		side = _v
		_update_area()
@export var snap_to_grid:bool = false: #是否对齐网格
	set(_v):
		snap_to_grid = _v
		if snap_to_grid:_snap_to_grid()

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	_update_area()
	if Engine.is_editor_hint(): return #如果这段代码在编辑器中执行则立即返回
	monitoring = true
	body_entered.connect(on_body_entered)

func _update_area() -> void:
	if not collision_shape:
		collision_shape = get_node("CollisionShape2D")
	var new_rect:Vector2 = Vector2(32,32)
	var new_position:Vector2 = Vector2.ZERO
	match side:
		SIDE.UP:
			new_rect.x *= size
			new_position.y -= 16
		SIDE.DOWN:
			new_rect.x *= size
			new_position.y += 16
		SIDE.LEFT:
			new_rect.y *= size
			new_position.x -= 16
		SIDE.RIGHT:
			new_rect.y *= size
			new_position.x += 16	
	collision_shape.shape.size = new_rect		
	collision_shape.position = new_position
	
func _snap_to_grid() -> void:
	position.x = round(position.x / 16) * 16
	position.y = round(position.y / 16) * 16
	
func on_body_entered(body:Node2D) -> void:
	if body is Player:
		GlobalLevelManager.load_new_level(level, target_transition_area, Vector2.ZERO) 

func _place_player() -> void:
	GlobalPlayerManager.set_player_position(global_position + GlobalLevelManager.position_offset)
	
func _get_offset() -> Vector2:
	todo
