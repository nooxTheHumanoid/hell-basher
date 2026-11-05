extends Area2D

@onready var hitbox: CollisionShape2D = $CollisionShape2D
@onready var linger: Timer = $Timer
func _ready() -> void:
	hitbox.disabled = false
	visible = true
	linger.start()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var knockback_direction = (body.global_position - global_position).normalized()
		body.apply_KB(knockback_direction,400.0,0.12,false)
		body.rocketJump()

func _on_timer_timeout() -> void:
	hitbox.disabled = true
	visible = false
	queue_free()
