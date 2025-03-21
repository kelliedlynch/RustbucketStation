extends Control

@onready var origin_label: Label = find_child("OriginLabel")
@onready var target_label: Label = find_child("TargetLabel")
@onready var location_label: Label = find_child("LocationLabel")
@onready var objective_label: Label = find_child("ObjectiveLabel")
@onready var time_remaining_label: Label = find_child("TimeRemainingLabel")
@onready var assigned_crew: Control = find_child("AssignedCrew")

#var pilot: Pilot:
	#set(value):
		#pilot = value
		#assigned_crew.pilot = value

var mission: Mission:
	set(value):
		mission = value
		
func _process(delta: float) -> void:
	origin_label.text = mission.origin.name
	target_label.text = mission.target.name
	location_label.text = mission.location.name
	objective_label.text = mission.objective.name
	if not mission.crew.is_empty():
		assigned_crew.visible = true
		assigned_crew.pilot = mission.crew[0]
	else:
		assigned_crew.visible = false
