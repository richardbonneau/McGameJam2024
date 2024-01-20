extends Node3D

@export var player_index:int = 0
var score_to_display:int = 0

@onready var score_label:Label = $Score

func _ready() -> void:
	Scoring.player_scored.connect(display_new_score)

func display_new_score(scoring_player_index:int, score_to_add:int):
	if player_index == scoring_player_index:
		score_to_display += score_to_add
		score_label.text = str(score_to_display)
