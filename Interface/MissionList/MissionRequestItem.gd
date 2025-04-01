extends MarginContainer

@onready var components: MissionComponentsRow = find_child("MissionComponents")
@onready var populate_button: Button = find_child("PopulateMission")

var request: MissionRequest:
	set(value):
		request = value
		if not is_inside_tree(): await ready
		components.mission = value

signal request_selected

func _ready() -> void:
	populate_button.pressed.connect(_on_populate_button_pressed)
	
func _on_populate_button_pressed() -> void:
	request_selected.emit(request)
