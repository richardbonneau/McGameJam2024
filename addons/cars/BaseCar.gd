extends VehicleBody3D
class_name Car

@export var STEER_SPEED = 1.5
@export var STEER_LIMIT = 0.6
var steer_target = 0
@export var engine_force_value = 40

@onready var player_gas:String = "player"+str(get_parent().player_index+1)+"_gas"
@onready var player_brake:String = "player"+str(get_parent().player_index+1)+"_brake"
@onready var player_turn_left:String = "player"+str(get_parent().player_index+1)+"_turn_left"
@onready var player_turn_right:String = "player"+str(get_parent().player_index+1)+"_turn_right"
@onready var player_num = get_parent().player_index + 1
func _ready():
	CustomizationManager.change_part.connect(_on_customization_happened)

func _physics_process(delta):
	if not GameManager.current_phase == GameManager.GamePhases.GAME: return
	var speed = linear_velocity.length()*Engine.get_frames_per_second()*delta
	traction(speed)
	$Hud/speed.text=str(round(speed*3.8))+"  KMPH"

	var fwd_mps = transform.basis.x.x
	steer_target = Input.get_action_strength(player_turn_left) - Input.get_action_strength(player_turn_right)
	steer_target *= STEER_LIMIT
	if Input.is_action_pressed(player_brake):
	# Increase engine force at low speeds to make the initial acceleration faster.

		if speed < 20 and speed != 0:
			engine_force = clamp(engine_force_value * 3 / speed, 0, 300)
		else:
			engine_force = engine_force_value
	else:
		engine_force = 0
	if Input.is_action_pressed(player_gas):
		# Increase engine force at low speeds to make the initial acceleration faster.
		if fwd_mps >= -1:
			if speed < 30 and speed != 0:
				engine_force = -clamp(engine_force_value * 10 / speed, 0, 300)
			else:
				engine_force = -engine_force_value
		else:
			brake = 1
	else:
		brake = 0.0
		
	if Input.is_action_pressed("ui_select"):
		brake=3
		$wheal2.wheel_friction_slip=0.8
		$wheal3.wheel_friction_slip=0.8
	else:
		$wheal2.wheel_friction_slip=3
		$wheal3.wheel_friction_slip=3
	steering = move_toward(steering, steer_target, STEER_SPEED * delta)

func traction(speed):
	apply_central_force(Vector3.DOWN*speed)

func _on_customization_happened(player, type, model):
	if not player == player_num: return
	
	if type == "Wheel": change_wheels(model)
	elif type == "Body": change_body(model)

func change_wheels(model:PackedScene):
	var wheels = [$wheal0, $wheal1, $wheal2, $wheal3 ]
	for wheel in wheels:
		wheel.get_child(0).queue_free()
		var instance:Node3D = model.instantiate()
		wheel.add_child(instance)
		instance.global_transform.origin = wheel.global_transform.origin
		

func change_body(model:PackedScene):
	$Body.get_child(0).queue_free()
	for child in self.get_children():
		if child is CollisionShape3D:
			child.queue_free()
	
	var instance:Node3D = model.instantiate()
	$Body.add_child(instance)
	instance.global_transform.origin = self.global_transform.origin
	
	var model_static_body = instance.get_node("%StaticBody3D")
	var collision_shapes:Array[Node] = model_static_body.get_children()
	
	# Bring Collisions over to the car controller
	for collision in collision_shapes:
		model_static_body.remove_child(collision)
		self.add_child(collision)
	
	var wheel_pos = instance.get_node("%WheelPositions")
	
	var i = 0
	for pos in wheel_pos.get_children():
		var wheel = get_node("wheal"+str(i))
		wheel.global_transform.origin = Vector3.ZERO
		print(pos.global_transform.origin)
		print(wheel.global_transform.origin)
		print(wheel)
		print("----")
		i += 1
