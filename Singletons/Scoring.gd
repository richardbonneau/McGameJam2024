extends Node

signal player_scored(player_index:int, score_to_add:int)

var player_1_score:int = 0
var player_2_score:int = 0

var score_zones:Array[Area3D]
var current_score_zone_index:int = 0
var current_multiplier:int = 2
var players_in_zone:Dictionary = {
	"player1": false,
	"player2": false
}

func _ready()->void:
	player_scored.connect(on_player_scored)

func on_player_scored(player_index:int, score_to_add:int):
	if player_index == 0: player_1_score += score_to_add
	elif player_index == 1: player_2_score += score_to_add

func init_score_multiplier_zones(zone:Area3D)->void:
	score_zones.append(zone)

func activate_score_zone():
	await get_tree().create_timer(0.5).timeout
	for zone in score_zones:
		zone.visible = false
	score_zones[current_score_zone_index].visible = true


func get_active_zone_location()-> Vector3:
	if not score_zones.is_empty() and score_zones[current_score_zone_index]:
		return score_zones[current_score_zone_index].global_transform.origin
	else: return Vector3.ZERO

func player_entered_scoring_zone(player):
	players_in_zone["player"+str(player.get_parent().player_index+1)] = true

func player_exited_scoring_zone(player):
	players_in_zone["player"+str(player.get_parent().player_index+1)] = false

