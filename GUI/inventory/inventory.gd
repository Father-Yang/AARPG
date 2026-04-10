#tip mode=always
#PanelContainer Styles StyleBoxTexture 选择图集Atlas
#texture margins 14外边距
#expand margins 10内边距
#添加一个control节点只是为了让方向键可以控制节点内的控件
#注意这个场景要加入到全局中进行自动加载
extends CanvasLayer

const INVENTORY_SLOT_SCENE = preload("uid://ne2kqd0uqn7a")

@onready var grid_container: GridContainer = %GridContainer

@export var data:InventoryData

var is_paused:bool = false

func _ready() -> void:
	hide_inventory()
	
func clear_inventory() -> void:
	for c in grid_container.get_children():
		c.queue_free()
		
func update_inventory() -> void:
	for s in data.slots:
		var slot:= INVENTORY_SLOT_SCENE.instantiate()
		grid_container.add_child(slot)
	grid_container.get_child(0).grab_focus() 

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		if is_paused == false:
			show_inventory()
		else:
			hide_inventory()
		get_viewport().set_input_as_handled() #阻止输入继续向上传播
		
func show_inventory() -> void:
	get_tree().paused = true
	is_paused = true
	update_inventory()
	show()
	
func hide_inventory() -> void:
	get_tree().paused = false
	is_paused = false
	clear_inventory()
	hide()
	
	
