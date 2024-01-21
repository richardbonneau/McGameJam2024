extends Node3D

@export var props:Array[RigidBody3D]

func _on_body_entered(body):
	if body is Car:
		for prop:RigidBody3D in props:
			prop.freeze = false
