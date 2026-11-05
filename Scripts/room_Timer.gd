extends Node2D


func _ready() -> void:
	get_tree().create_timer(Settings.RoomClear).timeout.connect(destroy)
	
func destroy():
	queue_free()
