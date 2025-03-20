extends Objective

func get_base_requirements(_mission: Mission) -> MissionRequirements:
	var req = MissionRequirements.new()
	req.min_stats.stealth = 20
	return req
	
func get_base_needs_satisfaction(_mission: Mission) -> Dictionary[String, int]:
	var needs: Dictionary[String, int] = {
		"adventure": 10,
		"vice": 20
	}
	return needs
	
#func apply_requirements_modifiers(_mission: Mission) -> MissionRequirements:
	#return MissionRequirements.new()
#func _init() -> void:
	#objective_verbs = PackedStringArray(["steal", "pilfer", "obtain", "yoink", "nab"])
	#objective_target = PackedStringArray(["the prince\'s crown jewels", "seven tons of butter", "a suspiciously ticking package", "a seriously offensive but valuable historical artifact", "everyone\'s left sock"])
	#objective_target_subjects = PackedStringArray(["a missive from the Prime Minister"])
	#objective_target_prepositions = PackedStringArray(["to"])
	#objective_target_objects = PackedStringArray(["the SpacePope\'s daughter"])
