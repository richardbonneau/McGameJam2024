extends Node3D

var has_been_hit:bool = false



func _on_rigid_body_3d_body_entered(body: Node) -> void:
	if body is Car:
		var mesh_instance:MeshInstance3D = $RigidBody3D/MeshInstance3D
		var mat:StandardMaterial3D = mesh_instance.get_active_material(0).duplicate()
		mat.albedo_color = Color("#00ab21")
		mesh_instance.set_surface_override_material(0, mat)
		
