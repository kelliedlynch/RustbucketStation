extends Node
class_name Mission

var origin: Faction
var target: Faction
var location: Location
var objective: Objective

var money_reward: int = 0
var rep_reward: Dictionary[Faction, int] = {}

func calculate_money_reward() -> int:
	return 100

func calculate_faction_rewards() -> Dictionary[Faction, int]:
	var rewards: Dictionary[Faction, int] = {}
	rewards[origin] = 50
	rewards[target] = -25
	return rewards
