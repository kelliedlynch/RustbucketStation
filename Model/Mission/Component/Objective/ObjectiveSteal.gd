extends Objective

func get_base_requirements(_mission: Mission) -> MissionRequirements:
	var req = MissionRequirements.new()
	req.stat_stealth_min = 20
	return req
	
#func apply_requirements_modifiers(_mission: Mission) -> MissionRequirements:
	#return MissionRequirements.new()
#func _init() -> void:
	#objective_verbs = PackedStringArray(["steal", "pilfer", "obtain", "yoink", "nab"])
	#objective_target = PackedStringArray(["the prince\'s crown jewels", "seven tons of butter", "a suspiciously ticking package", "a seriously offensive but valuable historical artifact", "everyone\'s left sock"])
	#objective_target_subjects = PackedStringArray(["a missive from the Prime Minister"])
	#objective_target_prepositions = PackedStringArray(["to"])
	#objective_target_objects = PackedStringArray(["the SpacePope\'s daughter"])
