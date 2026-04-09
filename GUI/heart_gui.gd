extends Control
class_name HeartGUI

@onready var sprite: Sprite2D = $Sprite2D

var value:int = 2 :
	set(_value):  #tip 利用setter方法设置
		value = _value
		update_sprite()
		
func update_sprite() -> void:
	sprite.frame = value
