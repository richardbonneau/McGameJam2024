extends Area3D

func _ready()->void:
	Scoring.init_score_multiplier_zones(self)

func _on_body_entered(body):
	if body is Car:
		Scoring.player_entered_scoring_zone(body)

func _on_body_exited(body):
	if body is Car:
		Scoring.player_exited_scoring_zone(body)
