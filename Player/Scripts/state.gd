extends Node
class_name State

static var player:Player

func _ready() -> void:
	pass # Replace with function body.
	
func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func process(delta:float) -> State:
	return null
	
func physics(delta:float) -> State:
	return null
	
func handle_input(event:InputEvent) ->  State:
	return null
