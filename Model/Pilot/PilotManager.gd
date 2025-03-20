extends Node

var all_pilots: Array[Pilot] = []
var in_station: Array[Pilot]:
	get:
		return all_pilots.filter(func(x): return x.status == PilotStatus.InStation)
var on_mission: Array[Pilot]:
	get:
		return all_pilots.filter(func(x): return x.status == PilotStatus.OnMission)
var adventuring: Array[Pilot]:
	get:
		return all_pilots.filter(func(x): return x.status == PilotStatus.Adventuring)

func _on_game_begin():
	Game.game_tick_advanced.connect(_on_game_tick_advanced)
	
func _on_game_tick_advanced(_tick: int):
	for pilot in in_station:
		# TODO: order by greatest need so full characters don't snipe from empty ones
		var mission = choose_mission(pilot)
		if mission:
			MissionManager.assign_pilot_to_mission(mission, pilot)
			pilot.status = PilotStatus.OnMission

func create_pilot():
	var pilot = Pilot.new(randi_range(1, 9))
	pilot.status = PilotStatus.InStation
	all_pilots.append(pilot)

func choose_mission(pilot: Pilot) -> Mission:
	var low_needs = {}
	var total_deficit = 0
	for need in pilot.needs:
		total_deficit += 100 - pilot.needs[need]
		if pilot.needs[need] < 20:
			low_needs[need] = pilot.needs[need]
	#if low_needs.is_empty():
		#return null
	var mission_weights: Array[int] = []
	var mission_selections: Array[Mission] = []
	for mission in MissionManager.posted_missions:
		if not mission.is_pilot_eligible(pilot): continue
		if mission.crew.size() >= mission.crew_size: 
			continue
		var weight = 0
		var mission_needs = mission.needs_satisfaction
		for need in mission_needs:
			if low_needs.has(need):
				weight += 100
			if pilot.needs[need] < 100:
				weight += min((100 - pilot.needs[need]), mission_needs[need])
		if weight > 0:
			mission_weights.append(weight)
			mission_selections.append(mission)
	if mission_weights.is_empty(): return null
	var index = Utility.rng.rand_weighted(mission_weights)
	return mission_selections[index]

func return_to_station(pilot: Pilot):
	pilot.status = PilotStatus.InStation
