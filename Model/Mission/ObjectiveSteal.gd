extends Objective

func get_base_requirements(_mission: Mission) -> MissionRequirements:
	var req = MissionRequirements.new()
	req.stat_stealth_min = 20
	#req.stat_pilot_min = 10
	#req.stat_charm_min = 10
	return req
	
#func apply_requirements_modifiers(_mission: Mission) -> MissionRequirements:
	#return MissionRequirements.new()
