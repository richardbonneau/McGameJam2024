extends Timer

func _on_timeout() -> void:
	GameManager.change_game_phase(GameManager.GamePhases.POST_GAME)
