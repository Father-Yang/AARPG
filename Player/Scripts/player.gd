extends CharacterBody2D
class_name Player

var direction:Vector2 = Vector2.ZERO
var cardinal_direction:Vector2 = Vector2.DOWN

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

func _ready() -> void:
	if state_machine:
		state_machine.initialize(self)

func _process(delta: float) -> void:
	#tip 获取player方向的方法有两种
	direction = Input.get_vector("move_left","move_right","move_up","move_down")
	#direction = Vector2(
		#Input.get_axis("move_left","move_right"),
		#Input.get_axis("move_up","move_down")
	#).normalized()

func _physics_process(delta: float) -> void:
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
	
	
