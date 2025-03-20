extends Resource
class_name MissionRequirements

var _stat_value_floor: int = 0
var _stat_value_ceiling: int = 100

@export var min_stats: Dictionary[String, int] = {
	charm = _stat_value_floor,
	combat = _stat_value_floor,
	pilot = _stat_value_floor,
	stealth = _stat_value_floor,
	tech = _stat_value_floor
}

@export var max_stats: Dictionary[String, int] = {
	charm = _stat_value_ceiling,
	combat = _stat_value_ceiling,
	pilot = _stat_value_ceiling,
	stealth = _stat_value_ceiling,
	tech = _stat_value_ceiling
}
	
func add(reqs: MissionRequirements):
	for prop in reqs.min_stats:
		min_stats[prop] = clamp(min_stats[prop] + reqs.min_stats[prop], _stat_value_floor, _stat_value_ceiling)

func clamp_to(reqs: MissionRequirements):
	for prop in reqs.min_stats:
		min_stats[prop] = max(min_stats[prop], reqs.min_stats[prop])
	for prop in reqs.max_stats:
		max_stats[prop] = min(max_stats[prop], reqs.max_stats[prop])
