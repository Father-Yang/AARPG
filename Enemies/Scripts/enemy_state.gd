extends Node
class_name EnemyState

var enemy:Enemy
var enemy_state_machine:EnemyStateMachine

func _ready() -> void:
	pass # Replace with function body.
	
func init() -> void: pass	

func enter() -> void:pass
	
func exit() -> void: pass
	
func process(_delta:float) -> EnemyState: return null
	
func physics(_delta:float) -> EnemyState: return null

# enemy 不需要 输入
