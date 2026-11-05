extends RigidBody2D

const FILE_BEGIN = "res://Scenes/Sections/room"

func Open(hp):
	var next_level_number = randi_range(1,9)
	#var next_level_number = 6
	var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
	var room = load(next_level_path).instantiate()
	room.name = "room" + str(Stats.room)
	room.position.x = global_position.x + 16
	room.position.y = global_position.y + 8
	get_tree().get_root().get_node("/root/Level").add_child.call_deferred(room)
	Stats.room += 1
	if (Settings.SpeedMax == 5001 and Settings.fireCD >= 3.0 and Settings.RoomClear <= 15 and Settings.IframeDur <= 50 and Settings.simple_cam == false and Settings.SpeedAffectKB == false and Stats.room == 25):
		SaveData.contents_to_save.TrueHell = true
		SaveData._save()
	if (Settings.SpeedMax == 500 and Settings.fireCD == 10.0 and Settings.RoomClear <= 25 and Settings.IframeDur == 0 and Settings.simple_cam == false and Settings.SpeedAffectKB == false and Settings.Bhop == false and Stats.room == 5):
		SaveData.contents_to_save.ATorment = true
		SaveData._save()
	if (Settings.RoomClear == 5 and Stats.room == 10):
		SaveData.contents_to_save.InARush = true
		SaveData._save()
	if (Settings.OneShot == true or hp == 3) and Stats.room == 25:
		SaveData.contents_to_save.NoHit = true
		SaveData._save()
	queue_free()
