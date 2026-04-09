extends Node

const PLAYER_SCENE = preload("uid://b4sse476kdci4")

var player:Player
var player_spwaned:bool = false


func _ready() -> void:
	add_player_instance()
	await get_tree().create_timer(0.3).timeout
	player_spwaned = true #tip 防止意外重生
	
func add_player_instance() -> void:
	player = PLAYER_SCENE.instantiate()
	add_child(player)
	
func set_player_position(pos:Vector2) -> void:
	if player:
		player.global_position = pos
		
func set_parent(parent_node:Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	parent_node.add_child(player)
	
func unset_parent(parent_node:Node2D) -> void:
	if parent_node:
		parent_node.remove_child(player)
