extends RigidBody3D

var grass # Reference to your MultiMeshInstance3D with the shader

func _ready():
	grass = get_node("/root/Node3D/Grass")
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	# Check if the body is the grass
	if body == grass:
		# Assuming the MultiMeshInstance3D uses a ShaderMaterial with the 'player_position' parameter
		var material = grass.multimesh.material_override
		if material:
			material.set_shader_param("player_position", global_transform.origin)
