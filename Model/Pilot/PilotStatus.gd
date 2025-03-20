extends Resource
class_name PilotStatus

var name: String

func _init(with_name: String) -> void:
	name = with_name
	
func _to_string() -> String:
	return name

static var InStation = PilotStatus.new("Idle")
static var Adventuring = PilotStatus.new("Adventuring")
static var OnMission = PilotStatus.new("On Mission")
