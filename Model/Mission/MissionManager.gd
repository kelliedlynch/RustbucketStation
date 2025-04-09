extends Node

var posted_missions: Array[Mission]:
	get:
		return all_missions.filter(func(x): return x.status == Mission.MissionStatus.POSTED)
		
var active_missions: Array[Mission]:
	get:
		return all_missions.filter(func(x): return x.status == Mission.MissionStatus.IN_PROGRESS)
var all_missions: Array[Mission] = []
var incoming_requests: Array[MissionRequest] = []

signal mission_updated

func _on_game_begin():
	Game.game_tick_advanced.connect(_on_game_tick_advanced)
	for i in 7:
		generate_random_request()

func post_mission(mission: Mission):
	all_missions.append(mission)
	mission.status = Mission.MissionStatus.POSTED
	Game.game_tick_advanced.connect(mission._on_game_tick_advanced)
	mission_updated.emit(mission)

func remove_mission(mission: Mission):
	all_missions.erase(mission)
	mission_updated.emit(mission)

func assign_pilot_to_mission(mission: Mission, pilot: Pilot):
	mission.crew.append(pilot)
	mission_updated.emit(mission)

func generate_random_request():
	var o_fac = FactionComponent.new()
	o_fac.faction = Faction.AllFactions.pick_random()
	var req = MissionRequest.new(o_fac)
	var facs = Faction.AllFactions.duplicate()
	facs.erase(o_fac.faction)
	if randi() & 1:
		var t_fac = FactionComponent.new()
		t_fac.faction = facs.pick_random()
		req.target = t_fac
	else:
		var loc = LocationComponent.new()
		loc.location = LocationManager.AllLocations.pick_random()
		req.location = loc
	if not req.target and randi() & 1:
		var t_fac = FactionComponent.new()
		t_fac.faction = facs.pick_random()
		req.target = t_fac
	if not req.location and randi() & 1:
		var loc = LocationComponent.new()
		loc.location = LocationManager.AllLocations.pick_random()
		req.location = loc
	req.objective = Objective.AllObjectives.pick_random()
	incoming_requests.append(req)

func _on_game_tick_advanced(tick: int):
	pass

func calculate_duration(mission: Mission) -> int:
	var base = mission.components.reduce(func(accum, val): accum += val.get_base_duration(mission), 0)
	var modified = base
	for component in mission.components:
		modified += component.apply_duration_modifiers(mission, base)
	return modified
