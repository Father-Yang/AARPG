extends State
class_name StateIdle

@onready var walk: StateWalk = %Walk
@onready var attack: StateAttack = %Attack

func enter() -> void:
	player.update_animation("idle")
	
func exit() -> void:
	pass
	
func process(delta:float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null
	
func physics(delta:float) -> State:
	return null
	
func handle_input(event:InputEvent) ->  State:
	if event.is_action_pressed("attack"):
		return attack
	return null
