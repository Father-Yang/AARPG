extends Node2D
class_name Plant

@onready var hurt_box: HurtBox = $HurtBox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hurt_box.damaged.connect(on_take_damage)
	
func on_take_damage(_damage:int) -> void:
	queue_free()
