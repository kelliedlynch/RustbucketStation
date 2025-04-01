extends Control

@onready var components: MissionComponentsRow = find_child("MissionComponents")
@onready var time_remaining_label: Label = find_child("TimeRemainingLabel")
@onready var assigned_crew: Control = find_child("AssignedCrew")

#var pilot: Pilot:
	#set(value):
		#pilot = value
		#assigned_crew.pilot = value

var mission: Mission:
	set(value):
		mission = value
		if not is_inside_tree(): await ready
		components.mission = value
		_on_mission_updated(value)
		
func _ready() -> void:
	MissionManager.mission_updated.connect(_on_mission_updated)
		
func _on_mission_updated(miss: Mission) -> void:
	if not miss == mission: return
	if not mission.crew.is_empty():
		assigned_crew.visible = true
		assigned_crew.pilot = mission.crew[0]
	else:
		assigned_crew.visible = false
