extends Objective

func apply_requirements_modifiers(_mission: Mission, base_val: MissionRequirements) -> MissionRequirements:
	var req = MissionRequirements.new_blank()
	req.stat_pilot_min = base_val.stat_pilot_min * .5
	return req
