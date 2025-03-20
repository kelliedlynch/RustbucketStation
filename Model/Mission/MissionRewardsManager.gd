extends RefCounted
class_name MissionRewardsManager


static func calculate_money_rewards(mission: Mission) -> int:
	var base_reward = mission.components.reduce(func(accum: int, val: MissionComponent): return accum + val.get_base_money_reward(mission), 0)
	var multiplied = _apply_money_reward_multipliers(mission, base_reward)
	return multiplied

static func calculate_rep_rewards(mission: Mission) -> Dictionary[Faction, int]:
	var base_reward: Dictionary[Faction, int] = _get_base_rep_rewards(mission)
	var multiplied : Dictionary[Faction, int] = _apply_rep_reward_multipliers(mission, base_reward)
	return multiplied

static func calculate_needs_rewards(mission: Mission) -> Dictionary[String, int]:
	var base: Dictionary[String, int] = _get_base_needs_satisfaction(mission)
	var modified: Dictionary[String, int] = _apply_needs_satisfaction_modifiers(mission, base)
	return modified

static func _get_base_money_rewards(mission: Mission):
	return mission.components.reduce(func(accum: int, val: MissionComponent): return accum + val.get_base_money_reward(mission), 0)

static func _apply_money_reward_multipliers(mission: Mission, base_reward: int):
	var multiplied = base_reward
	for component in mission.components:
		multiplied += component.apply_money_reward_multiplier(mission, base_reward)
	return multiplied

static func _get_base_rep_rewards(mission: Mission) -> Dictionary[Faction, int]:
	var base_reward: Dictionary[Faction, int] = {}
	for component: MissionComponent in mission.components:
		var component_rewards = component.get_base_rep_reward(mission)
		for key in component_rewards:
			if not base_reward.has(key):
				base_reward[key] = 0
			base_reward[key] += component_rewards[key]
	return base_reward
	
static func _apply_rep_reward_multipliers(mission: Mission, base_rewards: Dictionary[Faction, int]):
	var multiplied_rewards: Dictionary[Faction, int] = base_rewards.duplicate()
	for component: MissionComponent in mission.components:
		var component_rewards = component.apply_rep_reward_multiplier(mission, base_rewards)
		for key in component_rewards:
			if not base_rewards.has(key):
				continue
			multiplied_rewards[key] += component_rewards[key]
	return multiplied_rewards

static func _get_base_needs_satisfaction(mission: Mission) -> Dictionary[String, int]:
	var base: Dictionary[String, int] = {}
	for component: MissionComponent in mission.components:
		var component_rewards = component.get_base_needs_satisfaction(mission)
		for key in component_rewards:
			if not base.has(key):
				base[key] = 0
			base[key] += component_rewards[key]
	return base

static func _apply_needs_satisfaction_modifiers(mission: Mission, base: Dictionary[String, int]) -> Dictionary[String, int]:
	var modified: Dictionary[String, int] = base.duplicate()
	for component: MissionComponent in mission.components:
		var component_rewards = component.apply_needs_satisfaction_modifiers(mission, base)
		for key in component_rewards:
			if not base.has(key):
				continue
			modified[key] += component_rewards[key]
	return modified
