extends Control

@onready var menu_label = %big_label

@onready var Obj_1 = %Obj1
@onready var Obj_2 = %Obj2
@onready var Obj_3 = %Obj3

enum MenuTypes {
	WHEEL, BODY,
}
@onready var current_menu : MenuTypes = MenuTypes.WHEEL

var type_names : Dictionary = {
	MenuTypes.WHEEL : "Wheel",
	MenuTypes.BODY  : "Body",
}

var parts = {
	MenuTypes.WHEEL: [
	{
		"name": "Life Saver",
		"avatar": "res://Art/2D/wheel.svg",
		"model": preload("res://Art/3D/Wheels/LifeRing.tscn")
	},
	{
		"name": "Pizza",
		"avatar": "res://Art/2D/pngimg.com - car_wheel_PNG23302.png",
		"model": preload("res://Art/3D/Wheels/Pizza.tscn")
	},
	{
		"name": "Pizza",
		"avatar": "res://Art/2D/79a61c0f5e18328537e1a765859b3d5b.png",
		"model": preload("res://Art/3D/Wheels/Pizza.tscn")
	},
],
	MenuTypes.BODY:[
	{
		"name": "Desk",
		"avatar": "res://Art/2D/79a61c0f5e18328537e1a765859b3d5b.png",
		"model": preload("res://Logic/CarVariants/DeskCar.tscn")
	},
	{
		"name": "Tardis",
		"avatar": "res://Art/2D/pngimg.com - car_wheel_PNG23302.png",
		"model": preload("res://Logic/CarVariants/TardisCar.tscn")
	},
	{
		"name": "Tardis",
		"avatar": "res://Art/2D/79a61c0f5e18328537e1a765859b3d5b.png",
		"model": preload("res://Logic/CarVariants/TardisCar.tscn")
	},
]
}

var part_indexes = {
	MenuTypes.WHEEL: 0,
	MenuTypes.BODY: 0,
}

@onready var player_num = get_parent().get_parent().player_index+1

func _ready():
	GameManager.GamePhaseChange.connect(_on_game_phase_change)

func display_avatars():
	var avatars = []
	
	var first_avatar
	var second_avatar
	var third_avatar
	
	if part_indexes[current_menu] == 0: 
		first_avatar = load(parts[current_menu][-1].avatar)
	else: first_avatar = load(parts[current_menu][part_indexes[current_menu] -1].avatar)
	
	second_avatar = load(parts[current_menu][part_indexes[current_menu]].avatar)

	if part_indexes[current_menu] > parts[current_menu].size() - 2:
		third_avatar = load(parts[current_menu][0].avatar)
	else: third_avatar = load(parts[current_menu][part_indexes[current_menu] +1].avatar)
	
	Obj_1.texture_normal = first_avatar
	Obj_2.texture_normal = second_avatar
	Obj_3.texture_normal = third_avatar

func _on_next_menu_pressed():
	current_menu += 1
	if(current_menu == MenuTypes.size()):
		current_menu = 0
	menu_label.text = type_names[current_menu]
	display_avatars()
	GameManager.CustomCamSwitch.emit(player_num, current_menu)

func _on_back_menu_pressed():
	current_menu -= 1
	if(current_menu < 0):
		current_menu = MenuTypes.size() -1
	menu_label.text = type_names[current_menu]
	display_avatars()
	GameManager.CustomCamSwitch.emit(player_num, current_menu)


func _on_button_5_pressed():
	if part_indexes[current_menu] > 0: part_indexes[current_menu] -= 1
	else: part_indexes[current_menu] = parts[current_menu][part_indexes[current_menu]].size() - 1
	display_avatars()


func _on_button_4_pressed():
	if part_indexes[current_menu] < parts[current_menu][part_indexes[current_menu]].size() - 1: part_indexes[current_menu] += 1
	else: part_indexes[current_menu] = 0
	print("part_indexes[current_menu]",part_indexes[current_menu])
	display_avatars()

func _on_ready_pressed():
	GameManager.player_ready(player_num-1)
	$Ready.disabled = true

func _on_game_phase_change(new_phase):
	if new_phase == GameManager.GamePhases.READY or new_phase == GameManager.GamePhases.GAME: 
		get_parent().queue_free()


func _on_apply_change_to_car_pressed():
	CustomizationManager.change_part.emit(player_num, type_names[current_menu], parts[current_menu][part_indexes[current_menu]].model)
