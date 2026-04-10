#tip 这个CanvasLayer 要置顶 layer=2 player_hub layer=1
#mode 改为 always 不然会被暂停导致卡住
#Contorl 和 ColorRect 中的 mouse_filter = ignore 忽略掉鼠标
extends CanvasLayer

@onready var animation_player: AnimationPlayer = $Control/AnimationPlayer

func fade_in() -> bool:
	animation_player.play("fade_in")
	await animation_player.animation_finished
	return true


func fade_out() -> bool:
	animation_player.play("fade_out")
	await animation_player.animation_finished
	return true
