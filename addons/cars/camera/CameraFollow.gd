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
@onready var car_base = get_parent().get_parent()
@onready var player = car_base.get_parent()

@onready var player_num:String = str(player.player_index + 1)


func _ready():
	print(player_num)
	follow_this = get_parent()
	last_lookat = follow_this.global_transform.origin

func _physics_process(delta):
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
	elif Input.get_action_strength("player"+player_num+"_lookdown"):
		is_panning = true
		behind_cam.current = true
	else: 
		is_panning = false
		self.current = true
	
	
	global_transform.origin = global_transform.origin.lerp(target_pos, delta * speed)
	last_lookat = last_lookat.lerp(follow_this.global_transform.origin, delta * speed)
	
	if not is_panning: 
		look_at(last_lookat, Vector3.UP)

