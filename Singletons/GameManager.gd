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
var players_readiness = [false, false]

@onready var current_phase:GamePhases = GamePhases.MAIN_MENU

func change_game_phase(new_phase:GamePhases)->void:
	current_phase = new_phase
	GameManager.GamePhaseChange.emit(new_phase)

func player_ready(player:int):
	players_readiness[player] = true
	if players_readiness[0] and players_readiness[1]:
		change_game_phase(GamePhases.GAME)
