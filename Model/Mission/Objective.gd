extends MissionComponent
class_name Objective

@export var name: String
@export var objective_verbs: PackedStringArray
@export var objective_target: PackedStringArray
@export var objective_target_subjects: PackedStringArray
@export var objective_target_prepositions: PackedStringArray
@export var objective_target_objects: PackedStringArray

@export var requirements: MissionRequirements = MissionRequirements.new()

static var Steal = load("uid://vm5n6tjev3yw")
static var Deliver = load("uid://ce0ivbxrbl8et")
static var Scout = load("uid://owbmy3gfdr6v")
static var Sabotage = load("uid://x5h7jux0fayh")
static var Attack = load("uid://x2lnb48nbdm7")
static var Rescue = load("uid://dqyclv5u8wovt")

static var AllObjectives = [Steal, Deliver, Scout, Sabotage, Attack, Rescue]

func build_objective_text():
	pass
	
