extends Node3D

var is_customization_phase:bool = false

func _process(_delta:float)->void:
	if not is_customization_phase and is_one_of_custom_cams_current: return
	
	match GameManager.current_phase:
		GameManager.GamePhases.CUSTOMIZATION:
			$WheelCam.current = true
		GameManager.GamePhases.GAME: 
			$WheelCam.current = false
			$BodyCam.current = false
			$EngineCam.current = false

func game_phase_changed(new_phase:GameManager.GamePhases)->void:
	if new_phase == GameManager.GamePhases.CUSTOMIZATION:
		is_customization_phase = true
	else: is_customization_phase = false

func is_one_of_custom_cams_current():
	return $WheelCam.current or $BodyCam.current or $EngineCam.current
