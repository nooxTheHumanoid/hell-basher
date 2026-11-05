extends Area2D

@export var strenght = 200.0
@export var bypass = false
@export var stun = 0.12

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var knockback_direction = (body.global_position - global_position).normalized()
		body.apply_KB(knockback_direction,strenght,stun,bypass)
		body.hurt()
