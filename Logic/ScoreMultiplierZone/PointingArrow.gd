extends Node3D

@onready var multiplier_label:Label = get_parent().get_parent().get_node("Multiplier")

func _process(delta):
	if GameManager.current_phase == GameManager.GamePhases.GAME and not Scoring.players_in_zone["player"+str(get_parent().player_num)]: 
		look_at(Scoring.get_active_zone_location())
		multiplier_label.visible = false
		visible = true
		
	else: 
		visible = false
		multiplier_label.visible = true
