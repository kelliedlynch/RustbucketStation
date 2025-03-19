extends Node

var all_characters: Array[Character] = []
var in_station: Array[Character] = []
var on_mission: Array[Character] = []
var wandering: Array[Character] = []

func _on_game_begin():
	Game.game_tick_advanced.connect(_on_game_tick_advanced)
	
func _on_game_tick_advanced():
	for character in in_station:
		# TODO: order by greatest need so full characters don't snipe from empty ones
		var mission = choose_mission(character)
		if mission:
			MissionManager.assign_pilot_to_mission(mission, character)
			in_station.erase(character)
			on_mission.append(character)

func choose_mission(pilot: Character) -> Mission:
	var low_needs = {}
	var total_deficit = 0
	for need in pilot.needs:
		var need_val = pilot.get("need_" + need)
		total_deficit += 100 - need_val
		if need_val < 20:
			low_needs[need] = need_val
	#if low_needs.is_empty():
		#return null
	var mission_weights: Array[int] = []
	for mission in MissionManager.unclaimed_missions:
		if not mission.is_pilot_eligible(pilot): continue
		var weight = 0
		var mission_needs = mission.needs_satisfaction
		for need in mission_needs:
			if low_needs.has(need):
				weight += 100
			var pilot_val = pilot.get("need_" + need)
			if pilot_val < 100:
				weight += min((100 - pilot_val), mission_needs[need])
		mission_weights.append(weight)
	if mission_weights.is_empty(): return null
	var index = Utility.rng.rand_weighted(mission_weights)
	return MissionManager.unclaimed_missions[index]
