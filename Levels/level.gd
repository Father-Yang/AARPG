extends Node2D
class_name Level


func _ready() -> void:
	self.y_sort_enabled = true
	GlobalPlayerManager.set_parent(self)
	GlobalLevelManager.level_load_started.connect(_free_level) #有新的关卡加载则释放本身

func _free_level() -> void:
	GlobalPlayerManager.unset_parent(self) #tip 解除关卡与player的关系，防止player被free
	queue_free()
