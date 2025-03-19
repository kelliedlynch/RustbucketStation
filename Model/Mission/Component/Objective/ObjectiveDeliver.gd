extends Objective

func get_base_requirements(_mission: Mission) -> MissionRequirements:
	var req = MissionRequirements.new()
	req.stat_pilot_min = 10
	req.stat_charm_min = 10
	return req

func get_base_needs_satisfaction(_mission: Mission) -> Dictionary[String, int]:
	var needs: Dictionary[String, int] = {
	}
	return needs
