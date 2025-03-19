extends Resource
class_name MissionComponent
## Base class for any component of a mission that affects outcome or rewards
## Faction, Location, Objective

func get_base_money_reward(_mission: Mission) -> int:
	return 0
	
func get_base_rep_reward(_mission: Mission) -> Dictionary[Faction, int]:
	return {}
	
## Returns the amount to be added to the total by multipliers, not the total itself
func apply_money_reward_multiplier(_mission: Mission, _base_val: int) -> int:
	return 0
	
## Returns a dictionary of amounts to be added to total by multipliers
func apply_rep_reward_multiplier(_mission: Mission, _base_val: Dictionary[Faction, int]) -> Dictionary[Faction, int]:
	return {}

func get_base_requirements(_mission: Mission) -> MissionRequirements:
	return MissionRequirements.new()

func apply_requirements_modifiers(_mission: Mission, _base_val: MissionRequirements) -> MissionRequirements:
	return MissionRequirements.new_blank()

func get_base_needs_satisfaction(_mission: Mission) -> Dictionary[String, int]:
	return {} as Dictionary[String, int]

func apply_needs_satisfaction_modifiers(_mission: Mission, _base_val: Dictionary[String, int]) -> Dictionary[String, int]:
	return {} as Dictionary[String, int]
