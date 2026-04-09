extends CanvasLayer

var hearts:Array[HeartGUI] = [] #存放心形血条数量

@onready var h_flow_container: HFlowContainer = $Control/HFlowContainer

const HEART_GUI_SENCE = preload("uid://kw7be1rnxbgo")

func _ready() -> void:
	for i in range(20):
		var heart_gui:HeartGUI = HEART_GUI_SENCE.instantiate()
		h_flow_container.add_child(heart_gui)
		heart_gui.hide()
		hearts.append(heart_gui)
	
func _update_max_hp(max_hp:int) -> void:
	for index in roundi(max_hp * 0.5):
		hearts[index].show()
		
func update_hp(current_hp:int, max_hp:int) -> void:
	_update_max_hp(max_hp)
	for index in max_hp:
		_update_heart(index, current_hp)
	
func _update_heart(index:int, current_hp:int) -> void:
	hearts[index].value = clampi(current_hp - index * 2, 0, 2)
