extends Resource
class_name Character

var name: String

var need_adventure: int
var need_fame: int
var need_romance: int
var need_vice: int
var needs = ["adventure", "fame", "romance", "vice"]

var stat_pilot: int
var stat_combat: int
var stat_stealth: int
var stat_charm: int
var stat_tech: int
var stats = ["pilot", "combat", "stealth", "charm", "tech"]

var rank: int

var job: String

var portrait: Texture2D

func _init(at_rank: int):
	rank = at_rank
	name = NameGenerator.new_name()
	for need in needs:
		set("need_" + need, randi_range(1, 100))
	for stat in stats:
		set("stat_" + stat, clamp(at_rank * randi_range(1, 12), 1, 99))
	job = "Pilot" if randi() & 1 else "Space Wizard"
	portrait = get_random_portrait()
	
func get_random_portrait() -> Texture2D:
	var portraits = ResourceLoader.list_directory("res://Graphics/Portraits")
	var filename = portraits[randi_range(0, portraits.size() - 1)]
	return load("res://Graphics/Portraits/" + filename)

func pick_current_action():
	pass
