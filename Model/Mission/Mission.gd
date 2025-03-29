extends Resource
class_name Mission

var origin: FactionComponent
var target: FactionComponent
var location: LocationComponent
var objective: Objective

var crew_size: int = 1

var requirements: MissionRequirements:
	get:
		return MissionRequirementsManager.calculate_mission_requirements(self)

var money_reward: int:
	get:
		return MissionRewardsManager.calculate_money_rewards(self)
		
var rep_reward: Dictionary[Faction, int]:
	get:
		return MissionRewardsManager.calculate_rep_rewards(self)

var components: Array[MissionComponent]:
	get:
		return [origin, target, location, objective] as Array[MissionComponent]

var needs_satisfaction: Dictionary[String, int]:
	get:
		return MissionRewardsManager.calculate_needs_rewards(self)
		
var crew: Array[Pilot] = []

var ticks_remaining: int

var status: MissionStatus = MissionStatus.POSTED

func recalculate_requirements():
	requirements = MissionRequirementsManager.calculate_mission_requirements(self)

func get_eligible_pilots() -> Array[Pilot]:
	var eligible: Array[Pilot] = []
	var reqs = requirements
	
	for pilot in PilotManager.in_station:
		if is_pilot_eligible(pilot):
			eligible.append(pilot)
	return eligible

func is_pilot_eligible(pilot: Pilot) -> bool:
	var is_eligible = true
	for skill in pilot.skill_ranks:
		if pilot.skill_ranks[skill].value < requirements.min_skills[skill]:
			is_eligible = false
			break
	return is_eligible
	
func begin_mission():
	status = MissionStatus.IN_PROGRESS
	ticks_remaining = 1
	
func _on_game_tick_advanced(_tick: int):
	if status == MissionStatus.POSTED:
		recalculate_requirements()
		if crew.size() >= crew_size:
			begin_mission()
	elif status == MissionStatus.IN_PROGRESS:
		ticks_remaining -= 1
		if ticks_remaining <= 0:
			end_mission()

func end_mission():
	status = MissionStatus.COMPLETE
	Player.money += money_reward
	for rep in rep_reward:
		Player.reputation[rep] += rep_reward[rep]
	var needs = needs_satisfaction
	for pilot in crew:
		for need in needs:
			pilot.add_need(need, needs[need])
		PilotManager.return_to_station(pilot)
	crew.clear()
	MissionManager.remove_mission(self)

enum MissionStatus {
	POSTED,
	IN_PROGRESS,
	COMPLETE
}
