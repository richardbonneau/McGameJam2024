extends Node3D

@onready var player_index:String = str(get_parent().get_parent().player_index+1)
@onready var multiplier_label:Label = get_parent().get_parent().get_node("Multiplier")

func _process(delta):
	if not Scoring.players_in_zone["player"+player_index]: 
		look_at(Scoring.get_active_zone_location())
		multiplier_label.visible = false
		
	else: 
		visible = false
		multiplier_label.visible = true
