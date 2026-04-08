extends State
class_name StateStun

@export var anim_name:String = "stun"
@export var knockback_speed:float = 500.0
@export var decelerate_speed:float = 200.0
@export var invulnerable_duration:float = 0.5

@onready var idle: StateIdle = %Idle

var _damage_position:Vector2
var _direction:Vector2 	
var _animation_finsihed:bool = false
var next_state:State = null
	
func init() -> void: 
	player.player_damaged.connect(_on_player_damaged)	

func enter() -> void: 
	_animation_finsihed = false
	
	_direction = player.global_position.direction_to(_damage_position)
	player.velocity = _direction * (-knockback_speed)
	player.set_direction()
	
	#tip 先设置朝向再更新动画
	player.update_animation(anim_name)
	player.effect_animation_player.play("damage")
	player.animation_player.animation_finished.connect(_on_animation_finished)
	
	player.make_invulnerable(invulnerable_duration)
	

func exit() -> void:
	player.invulnerable = false
	next_state = null
	player.animation_player.animation_finished.disconnect(_on_animation_finished)
	
func process(delta:float) -> State: 
	player.velocity -= player.velocity * decelerate_speed * delta
	if _animation_finsihed:
		return next_state
	return null
	
func physics(_delta:float) -> State: return null

func _on_player_damaged(hit_box:HitBox) -> void:
	_damage_position = hit_box.global_position
	player_state_machine.change_state(self)# 这里才开始由信号触发状态
	
func _on_animation_finished(_anim_name: StringName) ->	void:
	_animation_finsihed = true
	next_state = idle
