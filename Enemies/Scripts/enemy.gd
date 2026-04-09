extends CharacterBody2D
class_name Enemy

signal direction_changed(new_direction:Vector2)
signal enemy_damaged(hit_box:HitBox)
signal enemy_destroyed(hit_box:HitBox)

@export var hp:int = 3

var cardinal_direction:Vector2 = Vector2.DOWN #基础方向
var direction:Vector2 = Vector2.ZERO
var invulnerable:bool = false #无敌状态

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var enemy_state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var hurt_box: HurtBox = $HurtBox
@onready var hit_box: HitBox = $HitBox


func _ready() -> void:
	hurt_box.take_damaged.connect(on_take_damaged)
	if enemy_state_machine:
		enemy_state_machine.initialize(self)

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
func set_direction(_direction:Vector2) -> bool:
	direction = _direction
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
	hp -= hit_box.damage
	if hp > 0:
		enemy_damaged.emit(hit_box)
	else:
		enemy_destroyed.emit(hit_box)	
	
