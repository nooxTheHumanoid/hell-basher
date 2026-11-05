extends Node

var simple_cam: bool = false
var Bhop: bool = false
var OneShot: bool = false
var IframeDur: float = 50.0
var KBIframe: bool = false
var RoomClear: int = 25
var fireCD: float = 3.0
var SpeedAffectKB: bool = false
var Particles: int = 200
var SpeedMax: int = 5001

func _ready() -> void:
	simple_cam = SaveData.contents_to_save.SimpleCam
	Bhop = SaveData.contents_to_save.Bhop
	OneShot = SaveData.contents_to_save.OneShot
	IframeDur = SaveData.contents_to_save.Iframes
	KBIframe = SaveData.contents_to_save.KBIframe
	RoomClear = SaveData.contents_to_save.RoomClear
	fireCD = SaveData.contents_to_save.fireCD
	SpeedAffectKB = SaveData.contents_to_save.SpeedAffectKB
	Particles = SaveData.contents_to_save.Particles
	SpeedMax = SaveData.contents_to_save.SpeedMax
