extends Resource
class_name Pilot

var name: String

#var need_adventure: int
#var need_fame: int
#var need_romance: int
#var need_vice: int
#var needs = ["adventure", "fame", "romance", "vice"]
var needs: Dictionary[String, int] = {
	adventure = 0,
	fame = 0,
	romance = 0,
	vice = 0
}


#var stat_pilot: int
#var stat_combat: int
#var stat_stealth: int
#var stat_charm: int
#var stat_tech: int
#var stats = ["pilot", "combat", "stealth", "charm", "tech"]
var stats: Dictionary[String, int] = {
	pilot = 0,
	combat = 0,
	stealth = 0,
	charm = 0,
	tech = 0
}

var skill_ranks: Dictionary[String, SkillRank] = {
	pilot = SkillRank.E,
	combat = SkillRank.E,
	stealth = SkillRank.E,
	charm = SkillRank.E,
	tech = SkillRank.E
}

var skill_exp: Dictionary[String, int] = {
	pilot = 0,
	combat = 0,
	stealth = 0,
	charm = 0,
	tech = 0
}


var rank: int

#var job: String

var portrait: Texture2D

var status: PilotStatus

func _init(_at_rank: int):
	#rank = at_rank
	name = NameGenerator.new_name()
	for need in needs:
		needs[need] = randi_range(1, 100)
	for skill in skill_ranks:
		var rank = SkillRank.random()
		skill_ranks[skill] = rank
		if rank == SkillRank.max:
			skill_exp[skill] = INF
		else:
			skill_exp[skill] = randi_range(0, rank.rank_up_exp)

	portrait = get_random_portrait()
	
func add_need(need: String, val: int):
	needs[need] = clamp(needs[need] + val, 0, 100)

func add_stat(stat: String, val: int):
	stats[stat] = clamp(stats[stat] + val, 0, 100)
	
func get_random_portrait() -> Texture2D:
	var portraits = ResourceLoader.list_directory("res://Graphics/Portraits")
	var filename = portraits[randi_range(0, portraits.size() - 1)]
	return load("res://Graphics/Portraits/" + filename)
