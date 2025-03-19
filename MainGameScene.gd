extends Control

@onready var rep_menu_button: Button = find_child("RepMenuButton")
@onready var rep_menu: Control = find_child("ReputationMenu")
@onready var mission_builder_button: Control = find_child("MissionBuilderButton")
@onready var mission_builder: Control = find_child("MissionBuilder")
@onready var mission_list: Control = find_child("MissionList")
@onready var mission_list_button: Button = find_child("MissionListButton")
@onready var advance_button: Button = find_child("AdvanceButton")

func _ready() -> void:
	rep_menu_button.pressed.connect(_toggle_rep_menu)
	mission_builder_button.pressed.connect(_toggle_mission_builder)
	mission_list_button.pressed.connect(_toggle_mission_list)
	advance_button.pressed.connect(Game.advance_game_tick)
	
func _toggle_rep_menu():
	rep_menu.visible = !rep_menu.visible
	rep_menu_button.set_pressed_no_signal(rep_menu.visible)

func _toggle_mission_builder():
	mission_builder.visible = !mission_builder.visible
	mission_builder_button.set_pressed_no_signal(mission_builder.visible)

func _toggle_mission_list():
	mission_list.visible = !mission_list.visible
	mission_list_button.set_pressed_no_signal(mission_list.visible)
