extends Node3D

@export var points:int = 100
var has_been_hit:bool = false

func _on_rigid_body_3d_body_entered(body: Node) -> void:
	if not has_been_hit and body is Car:
		has_been_hit = true
		var player_index:int = body.get_parent().player_index
		var mesh_instance:MeshInstance3D = $RigidBody3D/MeshInstance3D
		var mat:StandardMaterial3D = mesh_instance.get_active_material(0).duplicate()
		if player_index == 0: mat.albedo_color = Color("#00ab21")
		elif player_index == 1: mat.albedo_color = Color("ff0000")
		mesh_instance.set_surface_override_material(0, mat)
		
		var points_to_score:int = points
		if Scoring.players_in_zone["player"+str(player_index+1)]: points_to_score *= Scoring.current_multiplier
		Scoring.player_scored.emit(player_index, points_to_score)
		
