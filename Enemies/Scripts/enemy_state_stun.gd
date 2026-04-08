extends EnemyState
class_name EnemyStateStun

@export var anim_name:String = "stun"
@export var knockback_speed:float = 500.0
@export var decelerate_speed:float = 200.0

@export_category("AI")
@export var next_state:EnemyState = null
	
var animation_finsihed:bool = false
	
func init() -> void: 
	enemy.enemy_damaged.connect(_on_enemy_damaged)	

func enter() -> void: 
	enemy.invulnerable = true
	animation_finsihed = false
	var _direction:Vector2 = enemy.global_position.direction_to(enemy.player.global_position)
	enemy.set_direction(_direction)
	enemy.velocity = _direction * (-knockback_speed)
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	
func exit() -> void:
	enemy.invulnerable = false
	enemy.animation_player.animation_finished.disconnect(_on_animation_finished)
	
func process(delta:float) -> EnemyState: 
	if animation_finsihed:
		return next_state
	enemy.velocity -= enemy.velocity * decelerate_speed * delta
	return null
	
func physics(_delta:float) -> EnemyState: return null

func _on_enemy_damaged() -> void:
	enemy_state_machine.change_state(self)
	
func _on_animation_finished(_anim_name: StringName) ->	void:
	animation_finsihed = true
