extends EnemyState
class_name EnemyStateDestroy

@export var anim_name:String = "destroy"
@export var knockback_speed:float = 500.0
@export var decelerate_speed:float = 200.0
	

func init() -> void: 
	enemy.enemy_destroyed.connect(_on_enemy_destroyed)	

func enter() -> void: 
	enemy.invulnerable = true
	var _direction:Vector2 = enemy.global_position.direction_to(enemy.player.global_position)
	enemy.set_direction(_direction)
	enemy.velocity = _direction * (-knockback_speed)
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	
func exit() -> void:
	enemy.invulnerable = false
	enemy.animation_player.animation_finished.disconnect(_on_animation_finished)
	
func process(delta:float) -> EnemyState: 
	enemy.velocity -= enemy.velocity * decelerate_speed * delta
	return null
	
func physics(_delta:float) -> EnemyState: return null

func _on_enemy_destroyed() -> void:
	enemy_state_machine.change_state(self)
	
func _on_animation_finished(_anim_name: StringName) ->	void:
	enemy.queue_free()
