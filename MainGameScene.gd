extends Control

@onready var main_content_area: Control = find_child("MainContentArea")
@onready var rep_menu_button: Button = find_child("RepMenuButton")
@onready var rep_menu: Control = find_child("ReputationMenu")
@onready var mission_builder_button: Control = find_child("MissionBuilderButton")
@onready var mission_builder: Control = find_child("MissionBuilder")
@onready var mission_list: Control = find_child("MissionList")
@onready var mission_list_button: Button = find_child("MissionListButton")
@onready var advance_button: Button = find_child("AdvanceButton")
@onready var pilot_list: Control = find_child("PilotList")
@onready var pilot_list_button: Button = find_child("PilotListButton")

func _ready() -> void:
	_connect_button_to_menu(rep_menu_button, load("res://Interface/ReputationMenu.tscn"))
	_connect_button_to_menu(mission_builder_button, load("res://Interface/MissionBuilder/MissionBuilder.tscn"))
	_connect_button_to_menu(mission_list_button, load("res://Interface/MissionList/MissionList.tscn"))
	_connect_button_to_menu(pilot_list_button, load("res://Interface/PilotList/PilotList.tscn"))
	advance_button.pressed.connect(Game.advance_game_tick)
	
func _connect_button_to_menu(button: Button, menu: PackedScene):
	button.pressed.connect(_open_menu.bind(button, menu), CONNECT_ONE_SHOT)
	
func _reset_button(button: Button, menu):
	button.set_pressed_no_signal(false)
	_connect_button_to_menu(button, menu)
	
func _open_menu(button: Button, menu: PackedScene):
	for child in main_content_area.get_children():
		child.queue_free()
	var scene = menu.instantiate()
	button.pressed.connect(scene.queue_free, CONNECT_ONE_SHOT)
	scene.tree_exited.connect(_reset_button.bind(button, menu))
	main_content_area.add_child(scene)
	
func _toggle_rep_menu():
	rep_menu.visible = !rep_menu.visible
	rep_menu_button.set_pressed_no_signal(rep_menu.visible)

func _toggle_mission_builder():
	mission_builder.visible = !mission_builder.visible
	mission_builder_button.set_pressed_no_signal(mission_builder.visible)

func _toggle_mission_list():
	mission_list.visible = !mission_list.visible
	mission_list_button.set_pressed_no_signal(mission_list.visible)
	
func _toggle_pilot_list():
	pilot_list.visible = !pilot_list.visible
	pilot_list_button.set_pressed_no_signal(pilot_list.visible)
