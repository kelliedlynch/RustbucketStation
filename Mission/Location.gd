extends Resource
class_name Location

var name: String
var controller: Faction

class Mercury extends Location:
	func _init():
		name = "Mercury"
		controller = Faction.FascistEmpire
	
class Venus extends Location:
	func _init():
		name = "Venus"
		controller = Faction.SexyAliens
		
class Earth extends Location:
	func _init():
		name = "Earth"
		controller = Faction.PluckyRebels

static var AllLocations = [Mercury, Venus, Earth]
