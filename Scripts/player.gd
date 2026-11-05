extends CharacterBody2D

@onready var cam = $Camera2D
@onready var label = $Label
@onready var Sprites = $Sprite
@onready var kickbox = $KickHitbox/CollisionShape2D
@onready var FireCD = $Camera2D/FireCDBar
@onready var timerCDFire = $Camera2D/FireCDBar/Timer

@onready var slideP = $Slide
@onready var slideP2 = $Slide2

@onready var expp = $Exp
@onready var exp2 = $Exp2

@onready var lossScreen = preload("res://Scenes/Loss.tscn")
@export var HP = 3
var hearts_list: Array[TextureRect]
const BaseSPEED: float = 100.0
const JUMP_VELOCITY: float = -400.0
var speed: float = 0.0

var Jump_Avalible: bool = true
var stopcount = true
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
@export var Iframes: float = 0.0
var Dead = false

func _ready() -> void:
	if Settings.simple_cam:
		cam.position_smoothing_enabled = false
	else:
		cam.position_smoothing_enabled = true
	if Settings.OneShot:
		HP = 1
	FireCD.max_value = Settings.fireCD
	FireCD.value = Settings.fireCD
	if Settings.fireCD > 0:
		timerCDFire.wait_time = Settings.fireCD
		FireCD.visible = true
	else:
		FireCD.visible = false
	var hearts = $Camera2D/HBoxContainer
	for child in hearts.get_children():
		hearts_list.append(child)
		update_hearts()
	slideP.emitting = false
	slideP2.emitting = false
	expp.emitting = false
	exp2.emitting = false
	if Settings.Particles != 0:
		@warning_ignore("integer_division")
		slideP.amount = Settings.Particles/2
		@warning_ignore("integer_division")
		slideP2.amount = Settings.Particles/2
		@warning_ignore("integer_division")
		expp.amount = Settings.Particles/2
		@warning_ignore("integer_division")
		exp2.amount = Settings.Particles/2
		slideP.visible = true
		slideP2.visible = true
		expp.visible = true
		exp2.visible = true
	else:
		slideP.visible = false
		slideP2.visible = false
		expp.visible = false
		exp2.visible = false
	slideP.gravity.x = 0
	slideP2.gravity.x = 0

func _process(delta: float) -> void:
	if Iframes > 0.0:
		Iframes -= delta * 10
		Sprites.self_modulate = Color("ffffff69")
	else:
		Sprites.self_modulate = Color("ffffff")
		
	if FireCD.value == FireCD.max_value and Input.is_action_just_pressed("Fire") and stopcount:
		FireCD.value = 0
		if stopcount:
			stopcount = false
			timerCDFire.start()
			get_tree().create_timer(timerCDFire.wait_time).timeout.connect(STOPCDBAR)
		stopcount = false
	if FireCD.value < FireCD.max_value and stopcount == false:
		#Stop fucking looping the bar!!!
		#FUCK YOU MEAN IT LOOPS ONE MORE TIME???
		if FireCD.value == FireCD.max_value:
			stopcount = true
		if stopcount == false:
			FireCD.value = (FireCD.max_value - timerCDFire.time_left)
		if FireCD.value == FireCD.max_value:
			stopcount = true
	if position.y > 800 or Input.is_action_just_pressed("Suicide"):
		HP = 0
		hurt()
	if Settings.SpeedMax != 5001:
		if speed > Settings.SpeedMax:
			speed = Settings.SpeedMax
	if speed >= 10000:
		SaveData.contents_to_save.cannotStop = true
		SaveData._save()

func _physics_process(delta: float) -> void:
	if Dead == false:
		if get_global_mouse_position().x < global_position.x:
			Sprites.flip_h = true
			kickbox.position.x = -57
			slideP.position.x = -13
			slideP2.position.x = 7
			expp.position.x = -3
			exp2.position.x = 5
			expp.position.y = 23
			exp2.position.y = 20
			#slideP.gravity.x = 900
			#slideP2.gravity.x = 900
		else:
			Sprites.flip_h = false
			kickbox.position.x = 0
			slideP.position.x = -6
			slideP2.position.x = 12
			expp.position.x = -3
			exp2.position.x = 5
			expp.position.y = 20
			exp2.position.y = 23
			#slideP.gravity.x = -900
			#slideP2.gravity.x = -900
		if knockback_timer > 0.0:
			velocity = knockback
			knockback_timer -= delta
			if knockback_timer <= 0.0:
				knockback = Vector2.ZERO
		else:
			if not is_on_floor():
				velocity += get_gravity() * delta
				slideP.emitting = false
				slideP2.emitting = false
				if kickbox.disabled:
					Sprites.play("Jump")
			else:
				if speed > 0.0 and kickbox.disabled:
					if Input.is_action_pressed("Slide"):
						speed -= delta * 100
						Sprites.play("Slide")
						slideP.emitting = true
						slideP2.emitting = true
						expp.emitting = false
						exp2.emitting = false
						Jump_Avalible = false
					else:
						speed -= delta * 1500
						slideP.emitting = false
						slideP2.emitting = false
						expp.emitting = false
						exp2.emitting = false
				elif speed <= 0.0:
					speed = 0.0
					slideP.emitting = false
					slideP2.emitting = false
				if !Input.is_action_pressed("Slide"):
					Jump_Avalible = true

			# Handle jump.
			if Settings.Bhop:
				if Input.is_action_pressed("Jump") and Jump_Avalible and kickbox.disabled:
					velocity.y = JUMP_VELOCITY
					speed += 25.0
					Jump_Avalible = false
			else:
				if Input.is_action_just_pressed("Jump") and Jump_Avalible and kickbox.disabled:
					velocity.y = JUMP_VELOCITY
					speed += 25.0
					Jump_Avalible = false

			if Input.is_action_just_pressed("Kick") and kickbox.disabled:
				kickbox.disabled = false
				Sprites.play("Kick")
				slideP.emitting = false
				slideP2.emitting = false
				expp.emitting = false
				exp2.emitting = false
				get_tree().create_timer(0.5).timeout.connect(kickoffCD)
			else:
				if kickbox.disabled:
					var direction = 0
					if Input.is_action_pressed("Left"):
						direction = -1
					elif Input.is_action_pressed("Right"):
						direction = 1
					if direction:
						velocity.x = direction * (BaseSPEED + speed)
						label.text = "Speed: " + str(BaseSPEED+speed)
						if is_on_floor() and !Input.is_action_pressed("Slide"):
							Sprites.play("Walk")
							slideP.emitting = false
							slideP2.emitting = false
							expp.emitting = false
							exp2.emitting = false
					else:
						if speed > 0.0:
							velocity.x -= direction * (speed * delta)
							label.text = "Speed: " + str(speed)
						else:
							velocity.x = move_toward(velocity.x, 0, BaseSPEED+speed*delta)
							label.text = "Speed: " + str(speed)
							if !Input.is_action_pressed("Slide"):
								Sprites.play("Idle")
								slideP.emitting = false
								slideP2.emitting = false
								expp.emitting = false
								exp2.emitting = false
		move_and_slide()
	else:
		var screen = lossScreen.instantiate()
		get_parent().add_child(screen)

func apply_KB(direction: Vector2, force: float, knockback_duration: float, bypass: bool) -> void:
	if ((Iframes <= 0.0 or Settings.KBIframe) or bypass):
		if Settings.SpeedAffectKB:
			knockback += direction * force * (speed/100)
		else:
			knockback += direction * force
		speed += force/4
		knockback_timer = knockback_duration
	
func hurt():
	if Iframes <= 0.0:
		HP -= 1
		Iframes = Settings.IframeDur
	if HP <= 0:
		Dead = true
	update_hearts()
	
func kickoffCD():
	kickbox.disabled = true

func _on_kick_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Door"):
		body.Open(HP)

func update_hearts():
	for i in range(hearts_list.size()):
		hearts_list[i].visible = i < HP

func STOPCDBAR():
	stopcount = true
	FireCD.value = FireCD.max_value

func addSpeed(value: float):
	speed += value

func rocketJump():
	expp.emitting = true
	exp2.emitting = true
