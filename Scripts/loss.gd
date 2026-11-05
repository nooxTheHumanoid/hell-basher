extends CanvasLayer

@onready var Room = $Rooms
@onready var enemies = $Enemies
@onready var time = $Time
@onready var button = $Menu

var msec: int = 0
var sec: int = 0
var minutes: int = 0

func _ready() -> void:
	if get_tree().get_first_node_in_group("Player"):
		get_tree().get_first_node_in_group("Player").queue_free()
	Room.text = "Rooms: " + str(Stats.room)
	enemies.text = "Enemies: " + str(Stats.enemies)
	
	@warning_ignore("narrowing_conversion")
	msec = fmod(Stats.time_spent, 1) * 100
	@warning_ignore("narrowing_conversion")
	sec = fmod(Stats.time_spent, 60)
	@warning_ignore("narrowing_conversion")
	minutes = fmod(Stats.time_spent, 3600) / 60
	time.text = "Time: " + "%02d:%02d.%03d" % [minutes, sec, msec]


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu.tscn")
