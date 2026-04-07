extends Node
class_name EnemyStateMachine

var states:Array[EnemyState]
var pre_state:EnemyState
var current_state:EnemyState

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED #禁用process

func _process(delta: float) -> void:
	change_state(current_state.process(delta)) 
	
func _physics_process(delta: float) -> void:
	change_state(current_state.physics(delta))  
	
func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input(event))
	
func initialize(_enemy:Enemy) -> void:
	for node in get_children():
		if node is EnemyState:
			states.append(node)
	if states.size() > 0:
		states[0].player = _enemy
		change_state(states[0]) #执行默认状态
	process_mode = Node.PROCESS_MODE_INHERIT #继承模式

func change_state(new_state:EnemyState) -> void:
	if new_state == null || current_state == new_state:
		return
	if current_state:
		current_state.exit()
	pre_state = current_state
	current_state = new_state
	current_state.enter()
