extends HBoxContainer
class_name MissionComponentsRow

@onready var origin_label: Label = find_child("OriginLabel")
@onready var target_label: Label = find_child("TargetLabel")
@onready var location_label: Label = find_child("LocationLabel")
@onready var objective_label: Label = find_child("ObjectiveLabel")

# untyped because it can be either a mission or a request
var mission:
	set(value):
		mission = value
		if not is_inside_tree(): await ready
		_on_mission_updated(value)
		
func _ready() -> void:
	MissionManager.mission_updated.connect(_on_mission_updated)
		
# miss is untyped because it could be a Mission or a MissionRequest
func _on_mission_updated(miss: MissionBase) -> void:
	if not miss == mission: return
	origin_label.text = mission.origin.name if mission.origin else ""
	target_label.text = mission.target.name if mission.target else ""
	location_label.text = mission.location.name if mission.location else ""
	objective_label.text = mission.objective.name if mission.objective else ""
