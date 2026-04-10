extends Node

# tip C:\Users\用户名\AppData\Roaming\Godot\app_userdata\AARPG
const SAVE_PATH:String = "user://"

signal game_saved
signal game_loaded

var current_save:Dictionary = {
	scene_path = "",
	player = {
		max_hp = 1,
		hp = 1,
		pos_x = 1,
		pos_y = 1
	},
	items = [],
	quests = [],
	persistence = []
}

func save_game() -> void:
	_update_player_data()
	_update_scene_data()
	
	var file := FileAccess.open(SAVE_PATH + "save.sav",FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	file.store_line(save_json)
	file.close()
	
	game_saved.emit()
	
func load_game() -> void:
	var file := FileAccess.open(SAVE_PATH + "save.sav",FileAccess.READ)
	current_save = JSON.parse_string(file.get_line()) as Dictionary
	
	GlobalLevelManager.load_new_level(current_save.scene_path, "", Vector2.ZERO)
	await GlobalLevelManager.level_load_started
	#tip 等待转场动画之后再更新
	GlobalPlayerManager.set_player_position(Vector2(current_save.player.pos_x,current_save.player.pos_y))
	GlobalPlayerManager.set_health(current_save.player.hp, current_save.player.max_hp)
	await GlobalLevelManager.level_loaded
	game_loaded.emit() 
	
func _update_scene_data() -> void:
	var path:String = ""
	for c in get_tree().root.get_children():
		if c is Level:
			path = c.scene_file_path
			break
	current_save.scene_path = path
	
func _update_player_data() -> void:
	var p:Player = GlobalPlayerManager.player
	current_save.player.max_hp = p.max_hp
	current_save.player.hp = p.current_hp
	current_save.player.pos_x = p.global_position.x
	current_save.player.pos_y = p.global_position.y
	
