extends RefCounted
class_name MissionRequirementsManager

static func calculate_mission_requirements(mission: Mission) -> MissionRequirements:
	var base_requirements: MissionRequirements = _get_base_requirements(mission)
	var modified: MissionRequirements = _apply_requirements_modifiers(mission, base_requirements)
	return modified
	
static func _get_base_requirements(mission: Mission) -> MissionRequirements:
	var base: MissionRequirements = MissionRequirements.new()
	for component: MissionComponent in mission.components:
		base.merge_max(component.get_base_requirements(mission))
	return base

static func _apply_requirements_modifiers(mission: Mission, base_reqs: MissionRequirements) -> MissionRequirements:
	var modified_reqs: MissionRequirements = base_reqs.duplicate(true)
	for component: MissionComponent in mission.components:
		modified_reqs.add(component.apply_requirements_modifiers(mission, base_reqs))
	return modified_reqs
