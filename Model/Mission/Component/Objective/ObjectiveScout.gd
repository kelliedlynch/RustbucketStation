extends Objective

func get_base_requirements(_mission: Mission) -> MissionRequirements:
	var req = MissionRequirements.new()
	req.min_skills.pilot = 2.0
	return req

func get_base_needs_satisfaction(_mission: Mission) -> Dictionary[String, int]:
	var needs: Dictionary[String, int] = {
		"adventure": 10
	}
	return needs
