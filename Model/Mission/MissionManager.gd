extends Node

var unclaimed_missions: Array[Mission] = []
var active_missions: Array[Mission] = []
var all_missions: Array[Mission]:
	get:
		var arr = unclaimed_missions.duplicate()
		arr.append_array(active_missions)
		return arr

func post_mission(mission: Mission):
	unclaimed_missions.append(mission)

func assign_pilot_to_mission(mission: Mission, pilot: Character):
	mission.crew.append(pilot)
	unclaimed_missions.erase(mission)
	active_missions.append(mission)
	
