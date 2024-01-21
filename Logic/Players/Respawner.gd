extends Node3D

@onready var respawn_spot:Vector3 = Vector3(global_transform.origin.x, global_transform.origin.y + 10, global_transform.origin.z)

func _process(delta: float) ->void:
	if get_parent().player_index == 0 and Input.is_action_pressed("player1_respawn"): respawn_player()
	elif get_parent().player_index == 1 and Input.is_action_pressed("player2_respawn"): respawn_player()

func respawn_player()->void:
	for node in get_parent().get_children():
		if node is Car:
			node.global_transform.origin = respawn_spot
