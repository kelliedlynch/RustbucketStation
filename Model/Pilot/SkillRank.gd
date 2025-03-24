extends Resource
class_name SkillRank

var value: int
var name: String
var rank_up_exp: int



func _init(val: int, n: String, exp: int) -> void:
	value = val
	name = n
	rank_up_exp = exp
	
func _to_string() -> String:
	return name

# Get next rank
func get_next_rank() -> SkillRank:
	match name:
		"A":
			return null
		"B":
			return A
		"C":
			return B
		"D":
			return C
		"E":
			return D
		_:
			return null

# Create static vars for ranks A through E
static var A: SkillRank = SkillRank.new(4, "A", INF)
static var B: SkillRank = SkillRank.new(3, "B", 10000)
static var C: SkillRank = SkillRank.new(2, "C", 1000)
static var D: SkillRank = SkillRank.new(1, "D", 100)
static var E: SkillRank = SkillRank.new(0, "E", 10)

static var max: SkillRank = SkillRank.A
static var min: SkillRank = SkillRank.E

# Get a random skill rank
static func random() -> SkillRank:
	var ranks := [SkillRank.A, SkillRank.B, SkillRank.C, SkillRank.D, SkillRank.E]
	return ranks.pick_random()
