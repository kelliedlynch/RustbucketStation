extends MissionComponent
class_name Faction

@export var name: String

class SpaceWizardsFaction extends Faction:
	func _init() -> void:
		name = "Space Wizards"

class FascistEmpireFaction extends Faction:
	func _init() -> void:
		name = "FascistEmpire"

class PluckyRebelsFaction extends Faction:
	func _init() -> void:
		name = "Plucky Rebels"

class SexyAliensFaction extends Faction:
	func _init() -> void:
		name = "Sexy Aliens"
		
class GrossAliensFaction extends Faction:
	func _init() -> void:
		name = "GrossAliens"
		
class StationFaction extends Faction:
	func _init() -> void:
		name = "Yourself"
