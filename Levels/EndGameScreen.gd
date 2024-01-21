extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.GamePhaseChange.connect(game_phase_changed)

func game_phase_changed(new_phase:GameManager.GamePhases)->void:
	match new_phase:
		GameManager.GamePhases.POST_GAME: 
			self.visible = true
			$HBoxContainer/VBoxContainer/PlayerOneScore.text = str(Scoring.player_1_score)
			$HBoxContainer/VBoxContainer2/PlayerTwoScore.text = str(Scoring.player_2_score)
