extends Node

var posted_missions: Array[Mission]:
	get:
		return all_missions.filter(func(x): return x.status == Mission.MissionStatus.POSTED)
		
var active_missions: Array[Mission]:
	get:
		return all_missions.filter(func(x): return x.status == Mission.MissionStatus.IN_PROGRESS)
var all_missions: Array[Mission] = []

signal mission_updated

func _on_game_begin():
	Game.game_tick_advanced.connect(_on_game_tick_advanced)

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

func _on_game_tick_advanced(tick: int):
	pass
