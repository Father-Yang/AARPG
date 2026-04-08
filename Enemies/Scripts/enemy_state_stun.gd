extends EnemyState
class_name EnemyStateStun

@export var anim_name:String = "stun"
@export var knockback_speed:float = 500.0
@export var decelerate_speed:float = 200.0

@export_category("AI")
@export var next_state:EnemyState = null

var _damage_position:Vector2
var _direction:Vector2 	
var _animation_finsihed:bool = false
	
func init() -> void: 
	enemy.enemy_damaged.connect(_on_enemy_damaged)	

func enter() -> void: 
	enemy.invulnerable = true
	_animation_finsihed = false
	_direction = enemy.global_position.direction_to(_damage_position)
	enemy.set_direction(_direction)
	enemy.velocity = _direction * (-knockback_speed)
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	
func exit() -> void:
	enemy.invulnerable = false
	enemy.animation_player.animation_finished.disconnect(_on_animation_finished)
	
func process(delta:float) -> EnemyState: 
	if _animation_finsihed:
		return next_state
	enemy.velocity -= enemy.velocity * decelerate_speed * delta
	return null
	
func physics(_delta:float) -> EnemyState: return null

func _on_enemy_damaged(hit_box:HitBox) -> void:
	_damage_position = hit_box.global_position
	enemy_state_machine.change_state(self)# 这里才开始由信号触发状态
	
func _on_animation_finished(_anim_name: StringName) ->	void:
	_animation_finsihed = true
