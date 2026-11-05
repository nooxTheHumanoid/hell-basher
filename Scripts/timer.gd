extends Label

var msec: int = 0
var sec: int = 0
var minutes: int = 0

func _ready() -> void:
	Stats.time_spent = 0.0

func _process(delta) -> void:
	if Stats.room >= 1:
		Stats.time_spent += delta
	@warning_ignore("narrowing_conversion")
	msec = fmod(Stats.time_spent, 1) * 100
	@warning_ignore("narrowing_conversion")
	sec = fmod(Stats.time_spent, 60)
	@warning_ignore("narrowing_conversion")
	minutes = fmod(Stats.time_spent, 3600) / 60
	text = "%02d:%02d.%03d" % [minutes, sec, msec]
