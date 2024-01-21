extends Node3D

@export var props:Array[RigidBody3D]
@export var points:int = 100
var has_been_hit:bool = false

func _on_body_entered(body: Node) -> void:
	if not has_been_hit and body is Car:
		has_been_hit = true
		for prop:RigidBody3D in props:
			prop.freeze = false
		
		var player_index:int = body.get_parent().player_index
		
		var rng = RandomNumberGenerator.new()
		var points_to_score:int = rng.randi_range(points-10, points)
		if Scoring.players_in_zone["player"+str(player_index+1)]: points_to_score *= Scoring.current_multiplier
		Scoring.player_scored.emit(player_index, points_to_score)
		
