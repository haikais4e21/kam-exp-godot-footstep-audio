extends KinematicBody

var speed = 500
var gravity = 9.8
var velocity = Vector3()
var on_ground = false
var ground_normal = Vector3.UP
var footstep_sound = preload("res://footstep.ogg")
var audio_player = AudioStreamPlayer3D.new()

func _ready():
	add_child(audio_player)

func _process(delta):
	velocity.y -= gravity * delta
	velocity = move_and_slide(velocity, ground_normal)
	if is_on_floor():
		velocity.y = 0
		ground_normal = Vector3.UP
		if Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down"):
			play_footstep_sound()

func play_footstep_sound():
	if not audio_player.playing:
		audio_player.stream = footstep_sound
		audio_player.play()
		audio_player.seek(randf() * footstep_sound.length)
