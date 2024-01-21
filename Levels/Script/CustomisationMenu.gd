extends Control

@onready var menu_label = %big_label

@onready var Obj_1 = %Obj1
@onready var Obj_2 = %Obj2
@onready var Obj_3 = %Obj3

enum menu_types {
	WHEEL, BODY,
	 #ENGINE
}
@onready var current_menu : menu_types = menu_types.WHEEL
var type_names : Dictionary = {
	menu_types.WHEEL : "Wheel",
	menu_types.BODY  : "Body",
	#menu_types.ENGINE : "Engine"
}

var wheels = ["res://Art/2D/pngimg.com - car_wheel_PNG23302.png", "res://Art/2D/wheel.svg", "res://Art/2D/pngimg.com - car_wheel_PNG23302.png"]
var bodies = ["res://Art/2D/79a61c0f5e18328537e1a765859b3d5b.png", "res://Art/2D/79a61c0f5e18328537e1a765859b3d5b.png", "res://Art/2D/79a61c0f5e18328537e1a765859b3d5b.png"]
#var engines = ["res://Art/2D/pngimg.com - engine_PNG4.png", "res://Art/2D/pngimg.com - engine_PNG4.png", "res://Art/2D/pngimg.com - engine_PNG4.png"]

var type_assets : Dictionary = {
	menu_types.WHEEL : wheels,
	menu_types.BODY : bodies,
	#menu_types.ENGINE : engines
}

@onready var player_num = get_parent().get_parent().player_index+1

func _on_next_menu_pressed():
	current_menu += 1
	if(current_menu == menu_types.size()):
		current_menu = 0
	menu_label.text = type_names[current_menu]
	Obj_1.texture_normal = load(type_assets[current_menu][0])
	Obj_2.texture_normal = load(type_assets[current_menu][1])
	Obj_3.texture_normal = load(type_assets[current_menu][2])
	GameManager.CustomCamSwitch.emit(player_num, current_menu)

func _on_back_menu_pressed():
	current_menu -= 1
	if(current_menu < 0):
		current_menu = menu_types.size() -1
	menu_label.text = type_names[current_menu]
	
	Obj_1.texture_normal = load(type_assets[current_menu][0])
	Obj_2.texture_normal = load(type_assets[current_menu][1])
	Obj_3.texture_normal = load(type_assets[current_menu][2])
	GameManager.CustomCamSwitch.emit(player_num, current_menu)


func _on_button_5_pressed():
	var newAssetArr = []
	for i in range(1, menu_types.size()):
			newAssetArr.push_back(type_assets[current_menu][i])
	newAssetArr.push_back(type_assets[current_menu][0])
	type_assets[current_menu] = newAssetArr
	
	Obj_1.texture_normal = load(type_assets[current_menu][0])
	Obj_2.texture_normal = load(type_assets[current_menu][1])
	Obj_3.texture_normal = load(type_assets[current_menu][2])


func _on_button_4_pressed():
	var newAssetArr = []
	for i in range(0, menu_types.size()-1):
			newAssetArr.push_back(type_assets[current_menu][i])
	newAssetArr.push_front(type_assets[current_menu][menu_types.size()-1])
	type_assets[current_menu] = newAssetArr
	
	Obj_1.texture_normal = load(type_assets[current_menu][0])
	Obj_2.texture_normal = load(type_assets[current_menu][1])
	Obj_3.texture_normal = load(type_assets[current_menu][2])
	
	# CAR ASSET CHANGED TO THE NEW OBJ2
	
func changeCar():
	pass
	#car.changeStuff = obj2
