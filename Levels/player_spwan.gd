extends Node2D
class_name PlayerSpwan

func _ready() -> void:
	hide()
	if GlobalPlayerManager.player and not GlobalPlayerManager.player_spwaned:
		GlobalPlayerManager.player_spwaned = true
		GlobalPlayerManager.set_player_position(global_position)
