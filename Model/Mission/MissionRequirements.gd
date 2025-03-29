extends Resource
class_name MissionRequirements

@export var min_skills: Dictionary[String, float] = {
	charm = SkillRank.min.value,
	combat = SkillRank.min.value,
	pilot = SkillRank.min.value,
	stealth = SkillRank.min.value,
	tech = SkillRank.min.value
}

func add(reqs: MissionRequirements):
	for prop in reqs.min_skills:
		min_skills[prop] += reqs.min_skills[prop]
		min_skills[prop] = clamp(max(reqs.min_skills[prop], min_skills[prop]), 0.0, float(SkillRank.max.value))

func merge_max(reqs: MissionRequirements):
	for prop in reqs.min_skills:
		min_skills[prop] = max(min_skills[prop], reqs.min_skills[prop])

func clamp_to(reqs: MissionRequirements):
	for prop in reqs.min_skills:
		min_skills[prop] = clamp(min_skills[prop], 0.0, reqs.min_skills[prop])
