extends EnemyState
class_name EnemyStateWander

@export var anim_name:String = "walk"
@export var wander_speed:float = 30.0

@export_category("AI")
@export var state_animation_duration:float = 0.7
@export var state_cycles_min:int = 1
@export var state_cycles_max:int = 3
@export var next_state:EnemyState = null
	
var _timer:float 
const DIR_4:Array[Vector2] = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
	
func init() -> void: pass	

func enter() -> void: 
	_timer = randi_range(state_cycles_min, state_cycles_max) * state_animation_duration
	var _direction:Vector2 = DIR_4.pick_random()
	enemy.set_direction(_direction)
	enemy.velocity = _direction * wander_speed
	enemy.update_animation(anim_name)
	
func exit() -> void:
	_timer = 0.0
	
func process(_delta:float) -> EnemyState: 
	_timer -= _delta
	if _timer <= 0:
		return next_state
	return null
	
func physics(_delta:float) -> EnemyState: return null
