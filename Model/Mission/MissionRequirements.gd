extends Resource
class_name MissionRequirements

var _stat_value_floor: int = 0
var _stat_value_ceiling: int = 100

@export var stat_charm_min: int = 0
@export var stat_charm_max: int = 100
@export var stat_combat_min: int = 0
@export var stat_combat_max: int = 100
@export var stat_pilot_min: int = 0
@export var stat_pilot_max: int = 100
@export var stat_stealth_min: int = 0
@export var stat_stealth_max: int = 100
@export var stat_tech_min: int = 0
@export var stat_tech_max: int = 100

static func new_blank() -> MissionRequirements:
	var req = MissionRequirements.new()
	for prop in req.get_property_list():
		if prop.name.begins_with("stat_") and prop.name.ends_with("_max"):
			req.set(prop.name, 0)
	return req
	
func add(reqs: MissionRequirements):
	for prop in reqs.get_property_list():
		if prop.name.begins_with("stat_"):
			set(prop.name, clamp(get(prop.name) + reqs.get(prop.name), _stat_value_floor, _stat_value_ceiling))

func clamp_to(reqs: MissionRequirements):
	for prop in reqs.get_property_list():
		if prop.name.begins_with("stat_"):
			if prop.name.ends_with("_min"):
				set(prop.name, max(get(prop.name), reqs.get(prop.name)))
			elif prop.name.ends_with("_max"):
				set(prop.name, min(get(prop.name), reqs.get(prop.name)))
#var stats: Dictionary[String, int] = {
	#stat_charm_min = 0,
	#stat_charm_max = 100,
	#stat_combat_min = 0,
	#stat_combat_max = 100,
	#stat_pilot_min = 0,
	#stat_pilot_max = 100,
	#stat_stealth_min = 0,
	#stat_stealth_max = 100,
	#stat_tech_min = 0,
	#stat_tech_max = 100,
#}
#
#var stat_multipliers: Dictionary[String, float] = {
	#stat_charm_min = 1.0,
	#stat_charm_max = 1.0,
	#stat_combat_min = 1.0,
	#stat_combat_max = 1.0,
	#stat_pilot_min = 1.0,
	#stat_pilot_max = 1.0,
	#stat_stealth_min = 1.0,
	#stat_stealth_max = 1.0,
	#stat_tech_min = 1.0,
	#stat_tech_max = 1.0,
#}
