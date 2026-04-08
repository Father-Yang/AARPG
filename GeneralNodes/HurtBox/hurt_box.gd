extends Area2D
class_name HurtBox

signal take_damaged(hit_box:HitBox)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func take_damage(hit_box:HitBox) -> void:
	take_damaged.emit(hit_box)
