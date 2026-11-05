extends Node2D

func _process(_delta: float) -> void:
	if get_tree().get_first_node_in_group("Player"):
		var body = get_tree().get_first_node_in_group("Player")
		position.x = body.position.x
