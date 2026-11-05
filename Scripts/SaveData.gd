extends Node

const save_location = "user://SaveFile.json"

var contents_to_save: Dictionary = {
	"SimpleCam" = false,
	"Bhop" = true,
	"Enemies" = 0,
	"Rooms" = 0,
	"Time_spent" = 0.0,
	"OneShot" = false,
	"Iframes" = 50.0,
	"KBIframe" = false,
	"RoomClear" = 25,
	"fireCD" = 3.0,
	"SpeedAffectKB" = false,
	"Particles" = 200,
	"SpeedMax" = 5001,
	"TrueHell" = false,
	"NoHit" = false,
	"InARush" = false,
	"ATorment" = false,
	"cannotStop" = false
}

func _ready() -> void:
	#DirAccess.remove_absolute("user://SaveFile.json")
	_load()

func _save():
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_var(contents_to_save.duplicate())
	file.close()
	
func _load():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		var save_data = data.duplicate()
		contents_to_save.SimpleCam = save_data.SimpleCam
		contents_to_save.Bhop = save_data.Bhop
		contents_to_save.Rooms = save_data.Rooms
		contents_to_save.Enemies = save_data.Enemies
		contents_to_save.OneShot = save_data.OneShot
		contents_to_save.Iframes = save_data.Iframes
		contents_to_save.KBIframe = save_data.KBIframe
		contents_to_save.RoomClear = save_data.RoomClear
		contents_to_save.fireCD = save_data.fireCD
		contents_to_save.SpeedAffectKB = save_data.SpeedAffectKB
		contents_to_save.Particles = save_data.Particles
		contents_to_save.SpeedMax = save_data.SpeedMax
		#Achievements 
		contents_to_save.TrueHell = save_data.TrueHell
		contents_to_save.NoHit = save_data.NoHit
		contents_to_save.InARush = save_data.InARush
		contents_to_save.ATorment = save_data.ATorment
		contents_to_save.cannotStop = save_data.cannotStop
