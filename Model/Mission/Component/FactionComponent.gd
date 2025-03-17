extends MissionComponent
class_name FactionComponent

@export var faction: Faction

var name: String:
	get:
		return faction.name

func get_base_money_reward(mission: Mission) -> int:
	return 10 if mission.origin == self else 0
	
func get_base_rep_reward(mission: Mission) -> Dictionary[Faction, int]:
	var self_rep = 0
	if mission.origin == self and not mission.target == self:
		self_rep += 50
	if mission.target == self and not mission.origin == self:
		self_rep -= 25
	return { faction: self_rep }
	
func apply_money_reward_multiplier(_mission: Mission, _base_val: int) -> int:
	return 0
	
func apply_rep_reward_multiplier(_mission: Mission, _base_val: Dictionary[Faction, int]) -> Dictionary[Faction, int]:
	return {}
