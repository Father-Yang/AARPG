extends Node2D
class_name Plant

@onready var hurt_box: HurtBox = $HurtBox

func _ready() -> void:
	hurt_box.take_damaged.connect(on_take_damage)
	
func on_take_damage(_hit_box:HitBox) -> void:
	queue_free()
