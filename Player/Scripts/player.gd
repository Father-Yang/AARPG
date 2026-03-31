extends CharacterBody2D
class_name Player

const SPEED = 300.0
var direction:Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	
	direction = Input.get_vector("move_left","move_right","move_up","move_down")
	if direction != Vector2.ZERO:
		self.velocity = direction * SPEED
		#animated_sprite.play("move")

	else:
		self.velocity = Vector2.ZERO	
		#animated_sprite.play("idle")
		
	move_and_slide()
