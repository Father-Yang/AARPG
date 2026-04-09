extends Node2D
class_name Level


func _ready() -> void:
	self.y_sort_enabled = true
	GlobalPlayerManager.set_parent(self)
