extends Node2D

@onready var SimpleCam: CheckBox = $"Simple camera"
@onready var Bhop: CheckBox = $Bhop
@onready var OneTap: CheckBox = $OneTap
@onready var IframeRange: HSlider = $IFrames
@onready var FrameCounter: Label = $FrameCount
@onready var KBIframe: CheckBox = $KBIframe
@onready var roomT: Label = $roomtimer
@onready var roomR: HSlider = $room
@onready var fireT: Label = $fireCDLabel
@onready var fireR: HSlider = $fireCD
@onready var SAKB: CheckBox = $SpeedAffectKB
@onready var partT: Label = $particles
@onready var partR: HSlider = $particle
@onready var spT: Label = $speed2
@onready var spR: HSlider = $speed

@onready var Thell: Label = $True
@onready var nohit: TextureRect = $NoHit
@onready var rush: TextureRect = $InRush
@onready var pain: TextureRect = $Pain
@onready var speed: TextureRect = $Speed

func _ready() -> void:
	SimpleCam.button_pressed = SaveData.contents_to_save.SimpleCam
	Bhop.button_pressed = SaveData.contents_to_save.Bhop
	OneTap.button_pressed = SaveData.contents_to_save.OneShot
	IframeRange.value = SaveData.contents_to_save.Iframes
	FrameCounter.text = "Iframes: " + str(IframeRange.value)
	KBIframe.button_pressed = SaveData.contents_to_save.KBIframe
	roomR.value = SaveData.contents_to_save.RoomClear
	roomT.text = "Room Timer: " + str(roundi(roomR.value))
	fireR.value = SaveData.contents_to_save.fireCD
	fireT.text = "Fire cooldown: " + str(fireR.value)
	SAKB.button_pressed = SaveData.contents_to_save.SpeedAffectKB
	partR.value = SaveData.contents_to_save.Particles
	partT.text = "Particles: " + str(roundi(partR.value))
	spR.value = SaveData.contents_to_save.SpeedMax
	if spR.value == 5001:
		spT.text = "Max Speed: Unlimited"
	else:
		spT.text = "Max Speed: " + str(roundi(spR.value))
	
	if SaveData.contents_to_save.TrueHell:
		Thell.visible = true
	else:
		Thell.visible = false
	if SaveData.contents_to_save.NoHit:
		nohit.visible = true
	else:
		nohit.visible = false
	if SaveData.contents_to_save.InARush:
		rush.visible = true
	else:
		rush.visible = false
	if SaveData.contents_to_save.ATorment:
		pain.visible = true
	else:
		pain.visible = false
	if SaveData.contents_to_save.cannotStop:
		speed.visible = true
	else:
		speed.visible = false

func _on_simple_camera_toggled(toggled_on: bool) -> void:
	Settings.simple_cam = toggled_on
	SaveData.contents_to_save.SimpleCam = toggled_on
	SaveData._save()

func _on_bhop_toggled(toggled_on: bool) -> void:
	Settings.Bhop = toggled_on
	SaveData.contents_to_save.Bhop = toggled_on
	SaveData._save()

func _on_one_tap_toggled(toggled_on: bool) -> void:
	Settings.OneShot = toggled_on
	SaveData.contents_to_save.OneShot = toggled_on
	SaveData._save()

func _on_i_frames_value_changed(value: float) -> void:
	Settings.IframeDur = value
	SaveData.contents_to_save.Iframes = value
	FrameCounter.text = "Iframes: " + str(value)
	SaveData._save()

func _on_kb_iframe_toggled(toggled_on: bool) -> void:
	Settings.KBIframe = toggled_on
	SaveData.contents_to_save.KBIframe = toggled_on
	SaveData._save()

func _on_room_value_changed(value: float) -> void:
	@warning_ignore("narrowing_conversion")
	Settings.RoomClear = roundi(value)
	SaveData.contents_to_save.RoomClear = roundi(value)
	roomT.text = "Room Timer: " + str(roundi(value))
	SaveData._save()


func _on_fire_cd_value_changed(value: float) -> void:
	Settings.fireCD = value
	SaveData.contents_to_save.fireCD = value
	fireT.text = "Fire cooldown: " + str(value)
	SaveData._save()


func _on_speed_affect_kb_toggled(toggled_on: bool) -> void:
	Settings.SpeedAffectKB = toggled_on
	SaveData.contents_to_save.SpeedAffectKB = toggled_on
	SaveData._save()

func _on_particle_value_changed(value: float) -> void:
	@warning_ignore("narrowing_conversion")
	Settings.Particles = value
	SaveData.contents_to_save.Particles = value
	partT.text = "Particles: " + str(roundi(value))
	SaveData._save()


func _on_speed_value_changed(value: int) -> void:
	Settings.SpeedMax = value
	SaveData.contents_to_save.SpeedMax = value
	if spR.value == 5001:
		spT.text = "Max Speed: Unlimited"
	else:
		spT.text = "Max Speed: " + str(roundi(spR.value))
	SaveData._save()


func _on_option_button_item_selected(index: int) -> void:
	if index == 0:
		Settings.SpeedMax = 5001
		SaveData.contents_to_save.SpeedMax = 5001
		Settings.fireCD = 3.0
		SaveData.contents_to_save.fireCD = 3.0
		Settings.RoomClear = 25
		SaveData.contents_to_save.RoomClear = 25
		Settings.IframeDur = 50.0
		SaveData.contents_to_save.Iframes = 50.0
		Settings.simple_cam = false
		SaveData.contents_to_save.SimpleCam = false
		Settings.Bhop = true
		SaveData.contents_to_save.Bhop = true
		Settings.OneShot = false
		SaveData.contents_to_save.OneShot = false
		Settings.KBIframe = false
		SaveData.contents_to_save.KBIframe = false
		Settings.SpeedAffectKB = false
		SaveData.contents_to_save.SpeedAffectKB = false
	elif index == 1:
		Settings.SpeedMax = 1500
		SaveData.contents_to_save.SpeedMax = 1500
		Settings.fireCD = 1.5
		SaveData.contents_to_save.fireCD = 1.5
		Settings.RoomClear = 40
		SaveData.contents_to_save.RoomClear = 40
		Settings.IframeDur = 75.0
		SaveData.contents_to_save.Iframes = 75.0
		Settings.simple_cam = true
		SaveData.contents_to_save.SimpleCam = true
		Settings.Bhop = true
		SaveData.contents_to_save.Bhop = true
		Settings.OneShot = false
		SaveData.contents_to_save.OneShot = false
		Settings.KBIframe = true
		SaveData.contents_to_save.KBIframe = true
		Settings.SpeedAffectKB = false
		SaveData.contents_to_save.SpeedAffectKB = false
	elif index == 2:
		Settings.SpeedMax = 5001
		SaveData.contents_to_save.SpeedMax = 5001
		Settings.fireCD = 3.0
		SaveData.contents_to_save.fireCD = 3.0
		Settings.RoomClear = 15
		SaveData.contents_to_save.RoomClear = 15
		Settings.IframeDur = 50
		SaveData.contents_to_save.Iframes = 50
		Settings.simple_cam = false
		SaveData.contents_to_save.SimpleCam = false
		Settings.Bhop = true
		SaveData.contents_to_save.Bhop = true
		Settings.OneShot = false
		SaveData.contents_to_save.OneShot = false
		Settings.KBIframe = true
		SaveData.contents_to_save.KBIframe = true
		Settings.SpeedAffectKB = false
		SaveData.contents_to_save.SpeedAffectKB = false
	elif index == 3:
		Settings.SpeedMax = 500
		SaveData.contents_to_save.SpeedMax = 500
		Settings.fireCD = 10.0
		SaveData.contents_to_save.fireCD = 10.0
		Settings.RoomClear = 25
		SaveData.contents_to_save.RoomClear = 25
		Settings.IframeDur = 0
		SaveData.contents_to_save.Iframes = 0
		Settings.simple_cam = false
		SaveData.contents_to_save.SimpleCam = false
		Settings.Bhop = false
		SaveData.contents_to_save.Bhop = false
		Settings.OneShot = false
		SaveData.contents_to_save.OneShot = false
		Settings.KBIframe = false
		SaveData.contents_to_save.KBIframe = false
		Settings.SpeedAffectKB = false
		SaveData.contents_to_save.SpeedAffectKB = false
	
	SimpleCam.button_pressed = SaveData.contents_to_save.SimpleCam
	Bhop.button_pressed = SaveData.contents_to_save.Bhop
	OneTap.button_pressed = SaveData.contents_to_save.OneShot
	IframeRange.value = SaveData.contents_to_save.Iframes
	FrameCounter.text = "Iframes: " + str(IframeRange.value)
	KBIframe.button_pressed = SaveData.contents_to_save.KBIframe
	roomR.value = SaveData.contents_to_save.RoomClear
	roomT.text = "Room Timer: " + str(roundi(roomR.value))
	fireR.value = SaveData.contents_to_save.fireCD
	fireT.text = "Fire cooldown: " + str(fireR.value)
	SAKB.button_pressed = SaveData.contents_to_save.SpeedAffectKB
	partR.value = SaveData.contents_to_save.Particles
	partT.text = "Particles: " + str(roundi(partR.value))
	spR.value = SaveData.contents_to_save.SpeedMax
	if spR.value == 5001:
		spT.text = "Max Speed: Unlimited"
	else:
		spT.text = "Max Speed: " + str(roundi(spR.value))
	SaveData._save()
