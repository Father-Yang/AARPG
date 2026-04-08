extends EnemyState
class_name EnemyStateIdle

@export var anim_name:String = "idle"

@export_category("AI")
@export var state_duration_min_time:float = 0.5
@export var state_duration_max_time:float = 1.5
@export var next_state:EnemyState = null

var _timer:float = 0.0
	
func init() -> void: pass	

func enter() -> void: 
	enemy.velocity = Vector2.ZERO
	_timer = randf_range(state_duration_min_time, state_duration_max_time)
	enemy.update_animation(anim_name)
	
func exit() -> void:
	_timer = 0.0
	
func process(_delta:float) -> EnemyState: 
	_timer -= _delta
	if _timer <= 0:
		return next_state
	return null
	
func physics(_delta:float) -> EnemyState: return null
