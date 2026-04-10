#tip mode=always
extends CanvasLayer

@onready var save_button: Button = $VBoxContainer/SaveButton
@onready var load_button: Button = $VBoxContainer/LoadButton

var is_paused:bool = false

func _ready() -> void:
	hide_pause_menu()
	save_button.pressed.connect(on_save_pressed)
	load_button.pressed.connect(on_load_pressed)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_paused == false:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled() #阻止输入继续向上传播
		
func show_pause_menu() -> void:
	get_tree().paused = true
	is_paused = true
	show()
	save_button.grab_focus() #tip 设置控件焦点
	
func hide_pause_menu() -> void:
	get_tree().paused = false
	is_paused = false
	hide()
	
func on_save_pressed() -> void:
	if is_paused == false:
		return 
	GlobalSaveManager.save_game()
	hide_pause_menu()

func on_load_pressed() -> void:
	if is_paused == false:
		return 
	GlobalSaveManager.load_game()
	await GlobalLevelManager.level_load_started
	hide_pause_menu()
