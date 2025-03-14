extends Resource
class_name Mission

var origin: Faction
var target: Faction
var location: Location
var objective: Objective

var required_stats = {}

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
		var comp: Array[MissionComponent] = []
		for component in [origin, target, location, objective]:
			if component:
				comp.append(component)
		return comp

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
