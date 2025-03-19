extends Resource
class_name Mission

var origin: FactionComponent
var target: FactionComponent
var location: Location
var objective: Objective

#var test: Array[MissionComponent] = [origin, target, location, objective]

var requirements: MissionRequirements:
	get:
		var base_requirements: MissionRequirements = _get_base_requirements()
		var modified: MissionRequirements = _apply_requirements_modifiers(base_requirements)
		return modified

var money_reward: int:
	get:
		var base_reward = components.reduce(func(accum: int, val: MissionComponent): return accum + val.get_base_money_reward(self), 0)
		var multiplied = _apply_money_reward_multipliers(base_reward)
		return multiplied
		
var rep_reward: Dictionary[Faction, int]:
	get:
		var base_reward: Dictionary[Faction, int] = _get_base_rep_rewards()
		var multiplied : Dictionary[Faction, int] = _apply_rep_reward_multipliers(base_reward)
		return multiplied

var components: Array[MissionComponent]:
	get:
		var test: Array[MissionComponent] = [origin, target, location, objective]
		return test

var needs_satisfaction: Dictionary[String, int]:
	get:
		var base: Dictionary[String, int] = _get_base_needs_satisfaction()
		var modified: Dictionary[String, int] = _apply_needs_satisfaction_modifiers(base)
		return modified
		
var crew: Array[Character] = []

func _apply_money_reward_multipliers(base_reward):
	var multiplied = base_reward
	for component in components:
		multiplied += component.apply_money_reward_multiplier(self, base_reward)
	return multiplied

func _get_base_rep_rewards() -> Dictionary[Faction, int]:
	var base_reward: Dictionary[Faction, int] = {}
	for component: MissionComponent in components:
		var component_rewards = component.get_base_rep_reward(self)
		for key in component_rewards:
			if not base_reward.has(key):
				base_reward[key] = 0
			base_reward[key] += component_rewards[key]
	return base_reward
	
## Returns dictionary of fully-calculated after-multiplier rewards
func _apply_rep_reward_multipliers(base_rewards: Dictionary[Faction, int]):
	var multiplied_rewards: Dictionary[Faction, int] = base_rewards.duplicate()
	for component: MissionComponent in components:
		var component_rewards = component.apply_rep_reward_multiplier(self, base_rewards)
		for key in component_rewards:
			if not base_rewards.has(key):
				continue
			multiplied_rewards[key] += component_rewards[key]
	return multiplied_rewards

func _get_base_requirements() -> MissionRequirements:
	var base: MissionRequirements = MissionRequirements.new()
	for component: MissionComponent in components:
		base.clamp_to(component.get_base_requirements(self))
	return base

func _apply_requirements_modifiers(base_reqs: MissionRequirements) -> MissionRequirements:
	var modified_reqs: MissionRequirements = base_reqs.duplicate(true)
	for component: MissionComponent in components:
		modified_reqs.add(component.apply_requirements_modifiers(self, base_reqs))
	return modified_reqs

func _get_base_needs_satisfaction() -> Dictionary[String, int]:
	var base: Dictionary[String, int] = {}
	for component: MissionComponent in components:
		var component_rewards = component.get_base_needs_satisfaction(self)
		for key in component_rewards:
			if not base.has(key):
				base[key] = 0
			base[key] += component_rewards[key]
	return base

func _apply_needs_satisfaction_modifiers(base: Dictionary[String, int]) -> Dictionary[String, int]:
	var modified: Dictionary[String, int] = base.duplicate()
	for component: MissionComponent in components:
		var component_rewards = component.apply_needs_satisfaction_modifiers(self, base)
		for key in component_rewards:
			if not base.has(key):
				continue
			modified[key] += component_rewards[key]
	return modified

func get_eligible_pilots() -> Array[Character]:
	var eligible: Array[Character] = []
	var reqs = requirements
	
	for pilot in CharacterManager.in_station:
		if is_pilot_eligible(pilot):
			eligible.append(pilot)
	return eligible

func is_pilot_eligible(pilot: Character) -> bool:
	var is_eligible = true
	for prop in requirements.get_property_list():
		if prop.name.begins_with("stat_"):
			if prop.name.ends_with("_min"):
				if pilot.get(prop.name.left(-4)) < requirements.get(prop.name):
					is_eligible = false
					break
			if prop.name.ends_with("_max"):
				if pilot.get(prop.name.left(-4)) > requirements.get(prop.name):
					is_eligible = false
					break
	return is_eligible
