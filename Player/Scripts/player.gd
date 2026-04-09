extends CharacterBody2D
class_name Player

signal player_damaged(hit_box:HitBox)
signal player_destroyed(hit_box:HitBox)

@export var max_hp:int = 37

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var effect_animation_player: AnimationPlayer = $EffectAnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var hurt_box: HurtBox = $HurtBox

var current_hp:int = max_hp
var direction:Vector2 = Vector2.ZERO 
var cardinal_direction:Vector2 = Vector2.DOWN #基础方向向下
var invulnerable:bool = false #无敌状态

func _ready() -> void:
	GlobalPlayerManager.player = self
	update_hp(max_hp) 
	hurt_box.take_damaged.connect(on_take_damaged)
	if state_machine:
		state_machine.initialize(self)

func _process(_delta: float) -> void:
	#tip 获取player方向的方法有两种
	direction = Input.get_vector("move_left","move_right","move_up","move_down")
	#direction = Vector2(
		#Input.get_axis("move_left","move_right"),
		#Input.get_axis("move_up","move_down")
	#).normalized()

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
func set_direction() -> bool:
	if direction == Vector2.ZERO:
		return false
	var new_dir:Vector2 = cardinal_direction
	if direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	elif direction.y == 0:
		new_dir = Vector2.RIGHT if direction.x > 0 else Vector2.LEFT
	if  new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true
	

func update_animation(state:String) -> void:
	animation_player.play(state + "_" + animation_direction())  
	
func animation_direction() -> String:
	var anim_dir:String = ""
	if cardinal_direction == Vector2.DOWN:
		anim_dir = "down"
	elif cardinal_direction == Vector2.UP:
		anim_dir = "up"
	else:
		anim_dir = "side"
	return anim_dir
	
func on_take_damaged(hit_box:HitBox) -> void:
	if invulnerable:
		return
	update_hp(-hit_box.damage)
	if current_hp > 0:
		player_damaged.emit(hit_box)
	else:
		player_destroyed.emit(hit_box)
	
func make_invulnerable(duration:float = 1.0) -> void:
	if invulnerable: return
	invulnerable = true
	hurt_box.monitoring = false
	
	await get_tree().create_timer(duration).timeout
	
	hurt_box.monitoring = true
	invulnerable = false
	
func update_hp(amount:int) -> void:
	current_hp = clampi(current_hp + amount, 0 , max_hp) 
	PlayerHub.update_hp(current_hp, max_hp)
	
	
