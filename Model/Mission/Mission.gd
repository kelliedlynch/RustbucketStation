extends Resource
class_name Mission

var origin: Faction
var target: Faction
var location: Location
var objective: Objective

var money_reward: int = 0
var rep_reward: Dictionary[Faction, int] = {}

var components: Array[MissionComponent]

func recalculate_rewards():
	calculate_money_reward()
	calculate_reputation_rewards()

func calculate_money_reward():
	money_reward = 0
	money_reward = components.reduce(func(accum, val: MissionComponent): return accum + val.get_base_money_reward(self), money_reward)
	components.map(_apply_money_reward_multipliers)

func _apply_money_reward_multipliers(component: MissionComponent):
	money_reward = component.apply_money_reward_multiplier(self)

func calculate_reputation_rewards():
	var rewards: Dictionary[Faction, int] = {}
	components.map(_add_base_rep_rewards)
	components.map(_apply_rep_multipliers)
	return rewards

func _add_base_rep_rewards(component: MissionComponent):
	var component_rewards = component.get_base_rep_reward(self)
	for key in component_rewards:
		rep_reward[key] += component_rewards[key]
	
func _apply_rep_multipliers(component: MissionComponent):
	var rewards = component.apply_rep_reward_multiplier(self)
	for key in rewards:
		rep_reward[key] = rewards[key]
