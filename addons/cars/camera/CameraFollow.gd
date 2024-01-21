extends Camera3D


@export var target_distance = 5
@export var target_height = 2
@export var speed:=20.0
var follow_this = null
var last_lookat
var is_panning:bool=false 

@onready var left_cam = get_parent().get_node("LeftCam")
@onready var right_cam = get_parent().get_node("RightCam")
@onready var behind_cam = get_parent().get_node("BehindCam")
@onready var custom_cam_body = get_parent().get_node("CustomCamBody")
@onready var custom_cam_wheels = get_parent().get_node("CustomCamWheels")

@onready var car_base = get_parent().get_parent()
@onready var player = car_base.get_parent()

@onready var player_num:String = str(player.player_index + 1)


func _ready():
	follow_this = get_parent()
	last_lookat = follow_this.global_transform.origin
	GameManager.GamePhaseChange.connect(game_phase_changed)
	GameManager.CustomCamSwitch.connect(on_custom_cam_switch)
	GameManager.change_game_phase(GameManager.GamePhases.CUSTOMIZATION)
	

func _physics_process(delta):
	if not GameManager.current_phase == GameManager.GamePhases.GAME: return
	var delta_v = global_transform.origin - follow_this.global_transform.origin
	var target_pos = global_transform.origin
	
	# ignore y
	delta_v.y = 0.0
	
	if (delta_v.length() > target_distance):
		delta_v = delta_v.normalized() * target_distance
		delta_v.y = target_height
		target_pos = follow_this.global_transform.origin + delta_v
	else:
		target_pos.y = follow_this.global_transform.origin.y + target_height
	
	if Input.get_action_strength("player"+player_num+"_lookleft"): 
		is_panning = true
		left_cam.current = true
	elif  Input.get_action_strength("player"+player_num+"_lookright"):
		is_panning = true
		right_cam.current = true
	elif Input.get_action_strength("player"+player_num+"_lookbehind"):
		is_panning = true
		behind_cam.current = true
	else: 
		is_panning = false
		self.current = true
	
	global_transform.origin = global_transform.origin.lerp(target_pos, delta * speed)
	last_lookat = last_lookat.lerp(follow_this.global_transform.origin, delta * speed)
	
	if not is_panning: 
		look_at(last_lookat, Vector3.UP)

func game_phase_changed(new_phase:GameManager.GamePhases)->void:
	match new_phase:
		GameManager.GamePhases.CUSTOMIZATION: 
			custom_cam_wheels.current = true
			
		GameManager.GamePhases.GAME: 
			self.current = true
			
		_: print("Didnt find game phase")

func on_custom_cam_switch(player, new_cam_angle):
	if not str(player) == str(player_num) : return
	match new_cam_angle:
		GameManager.CustomCams.WHEELS:
			custom_cam_wheels.current = true
		GameManager.CustomCams.BODY:
			custom_cam_body.current = true
