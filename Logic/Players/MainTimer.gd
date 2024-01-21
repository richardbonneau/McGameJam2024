extends Timer

func _on_timeout() -> void:
	print("timeout")
	GameManager.change_game_phase(GameManager.GamePhases.POST_GAME)
