extends Node3D

var has_been_hit:bool = false

func _on_rigid_body_3d_body_entered(body: Node) -> void:
	print(body)
	if not has_been_hit and body is Car:
		has_been_hit = true
		var player_index:int = body.get_parent().player_index
		var mesh_instance:MeshInstance3D = $RigidBody3D/MeshInstance3D
		var mat:StandardMaterial3D = mesh_instance.get_active_material(0).duplicate()
		if player_index == 0: mat.albedo_color = Color("#00ab21")
		elif player_index == 1: mat.albedo_color = Color("ff0000")
		mesh_instance.set_surface_override_material(0, mat)
		
