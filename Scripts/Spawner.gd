extends Node2D

@export var enemy_scene : PackedScene

func _ready() -> void:
	var random = randi_range(1,2)
	if random == 1:
		var enemy = enemy_scene.instantiate()
		enemy.position = position
		add_child.call_deferred(enemy)
