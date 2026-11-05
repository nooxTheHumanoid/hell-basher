extends Button

func _on_pressed() -> void:
	Stats.room = 0
	Stats.enemies = 0
	get_tree().change_scene_to_file("res://Scenes/level.tscn")
