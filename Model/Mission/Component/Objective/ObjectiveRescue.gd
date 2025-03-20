extends Objective

func get_base_requirements(_mission: Mission) -> MissionRequirements:
	var req = MissionRequirements.new()
	req.min_stats.combat = 10
	req.min_stats.pilot = 10
	req.min_stats.charm = 10
	req.min_stats.stealth = 10
	return req

func get_base_needs_satisfaction(_mission: Mission) -> Dictionary[String, int]:
	var needs: Dictionary[String, int] = {
		"adventure": 10,
		"fame": 10,
		"romance": 20
	}
	return needs
