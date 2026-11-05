extends RigidBody2D

var grav = true
var timer = 2
var speed = 2
var direction = 1
func _ready() -> void:
	speed = randf_range(0.5,2)
	timer = randf_range(1,3)
	if randi_range(1,2) == 1:
		direction = -1
	if randi_range(1,3) != 1:
		queue_free()
	
func _process(_delta: float) -> void:
	if grav:
		get_tree().create_timer(timer).timeout.connect(switch)
		grav = false
	position.y += speed * direction

func switch():
	direction = direction * -1
	grav = true

func Open(_HP):
	Stats.enemies += 1
	queue_free()
