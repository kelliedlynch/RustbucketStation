extends Objective

func get_base_requirements(_mission: Mission) -> MissionRequirements:
	var req = MissionRequirements.new()
	req.min_skills.pilot = 1.0
	req.min_skills.charm = 1.0
	return req

func get_base_needs_satisfaction(_mission: Mission) -> Dictionary[String, int]:
	var needs: Dictionary[String, int] = {
		adventure = 1,
		fame = 1,
		romance = 1,
		vice = 1
	}
	return needs
