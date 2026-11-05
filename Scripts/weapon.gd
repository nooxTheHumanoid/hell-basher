extends Node2D

const explosion = preload("res://Scenes/explosion.tscn")
@onready var muzzle: Marker2D = $Marker2D
@onready var animator: AnimatedSprite2D = $Amins
@onready var fire: AudioStreamPlayer2D = $fire

var fireCDing = false

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0 , 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
		position.x = 0.25
	else:
		scale.y = 1
		position.x = 0.0
	if Input.is_action_just_pressed("Fire") and fireCDing == false:
		fireCDing = true
		var bullet_instance
		bullet_instance = explosion.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = muzzle.global_position
		animator.play("Fire")
		fire.play()
		get_tree().create_timer(Settings.fireCD).timeout.connect(offCD)

func offCD():
	fireCDing = false
