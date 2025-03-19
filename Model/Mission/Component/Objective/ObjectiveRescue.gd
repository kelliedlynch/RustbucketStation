extends Objective

func get_base_requirements(_mission: Mission) -> MissionRequirements:
	var req = MissionRequirements.new()
	req.stat_combat_min = 10
	req.stat_pilot_min = 10
	req.stat_charm_min = 10
	req.stat_stealth_min = 10
	return req

func get_base_needs_satisfaction(_mission: Mission) -> Dictionary[String, int]:
	var needs: Dictionary[String, int] = {
		"adventure": 10,
		"fame": 10,
		"romance": 20
	}
	return needs
