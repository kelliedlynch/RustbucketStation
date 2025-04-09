extends MissionComponent
class_name LocationComponent

@export var location: Location
var name: String:
	get:
		return location.name

func get_base_rep_reward(mission: Mission) -> Dictionary[Faction, int]:
	var rep: Dictionary[Faction, int] = {}
	if mission.target and mission.target.faction == location.controller:
		rep[mission.target.faction] = -20
	return rep

func get_base_duration(mission: Mission) -> int:
	return round(location.distance / 100)
