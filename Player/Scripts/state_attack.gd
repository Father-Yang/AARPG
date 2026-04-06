extends State
class_name StateAttack

@export var attack_sound:AudioStream
@export_range(1, 20, 0.5) var 加速度 = 5.0

@onready var idle: StateIdle = %Idle
@onready var walk: StateWalk = %Walk
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var animation_attack: AnimationPlayer = %AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var hit_box: HitBox = %HitBox


var attacking:bool = false

func enter() -> void:
	attacking = true
	
	player.update_animation("attack")
	animation_attack.play("attack_" + player.animation_direction())
	animation_player.animation_finished.connect(_on_attack_finished)
	
	audio_stream_player.stream = attack_sound
	audio_stream_player.pitch_scale = randf_range(0.9, 1.1) #随机音频高音
	audio_stream_player.play()
	
	await get_tree().create_timer(0.075).timeout #tip 设置时间间隔再让攻击框生效
	hit_box.monitoring = true
	
func exit() -> void:
	hit_box.monitoring = false
	animation_player.animation_finished.disconnect(_on_attack_finished) #tip exit时解除绑定
	attacking = false
	
func process(delta:float) -> State:
	player.velocity -= player.velocity * 加速度 * delta
	if not attacking:
		if player.direction != Vector2.ZERO:
			return walk
		else:
			return idle
	return null
	
func physics(delta:float) -> State:
	return null
	
func handle_input(event:InputEvent) ->  State:
	return null
	
func _on_attack_finished(anim_name:String) -> void:
	attacking = false
