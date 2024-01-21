extends Node

signal GamePhaseChange(new_game_phase)
signal CustomCamSwitch(player, new_cam_angle)

enum GamePhases {
	MAIN_MENU,
	CUSTOMIZATION,
	READY,
	GAME,
	POST_GAME
}

enum CustomCams {
	WHEELS,
	BODY
}

@onready var current_phase:GamePhases = GamePhases.MAIN_MENU

func change_game_phase(new_phase:GamePhases)->void:
	current_phase = new_phase
	GameManager.GamePhaseChange.emit(new_phase)
