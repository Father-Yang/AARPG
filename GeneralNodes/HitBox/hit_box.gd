extends Area2D
class_name HitBox

@export var damage:int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(on_area_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func on_area_entered(area:Area2D) -> void:
	if area is HurtBox:  #tip 判断如果受击框，则对它造成伤害
		area.take_damage(self) # 传递整个对象
