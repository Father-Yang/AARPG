extends CharacterBody2D
class_name Player

const SPEED = 100.0

var direction:Vector2 = Vector2.ZERO
var cardinal_direction:Vector2 = Vector2.DOWN
var state:String = "idle"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

func _process(delta: float) -> void:
	direction = Input.get_vector("move_left","move_right","move_up","move_down")
	if direction != Vector2.ZERO:
		self.velocity = direction * SPEED
		#animated_sprite.play("move")

	else:
		self.velocity = Vector2.ZERO	
		#animated_sprite.play("idle")
	if _set_state() || _set_direction():
		_update_animation()

func _physics_process(delta: float) -> void:
	move_and_slide()
	
func _set_direction() -> bool:
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
	
func _set_state() -> bool:
	var new_state = "idle" if direction == Vector2.ZERO else "walk"
	if new_state == state:
		return false
		
	state = new_state
	return true


func _update_animation() -> void:
	var anim_dir:String = ""
	if cardinal_direction == Vector2.DOWN:
		anim_dir = "down"
	elif cardinal_direction == Vector2.UP:
		anim_dir = "up"
	else:
		anim_dir = "side"
		
	animation_player.play(state + "_" + anim_dir)  
	
	
