extends Area2D

@export var speed: float = 100.0
@export var alwaysSpawn: bool = false

func _ready() -> void:
	if alwaysSpawn:
		pass
	else:
		if randi_range(1,10) != 10:
			queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.addSpeed(speed)
		queue_free()
