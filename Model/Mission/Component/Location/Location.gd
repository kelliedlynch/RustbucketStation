extends MissionComponent
class_name Location

@export var name: String
@export var controller: Faction

func get_base_rep_reward(mission: Mission) -> Dictionary[Faction, int]:
	var rep: Dictionary[Faction, int] = {}
	if mission.target and mission.target.faction == controller:
		rep[mission.target.faction] = -20
	return rep
