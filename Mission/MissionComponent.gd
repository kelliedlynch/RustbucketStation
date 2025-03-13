extends Resource
class_name MissionComponent
## Base class for any component of a mission that affects outcome or rewards
## Faction, Location, Objective

func get_base_money_reward(_mission: Mission) -> int:
	return 0
	
func get_base_rep_reward(_mission: Mission) -> Dictionary[Faction, int]:
	return {}
	
func apply_money_reward_multiplier(mission: Mission) -> int:
	return mission.money_reward
	
func apply_rep_reward_multiplier(mission: Mission) -> Dictionary[Faction, int]:
	return mission.rep_reward
