extends MissionComponent
class_name Location

var name: String
var controller: Faction

class Mercury extends Location:
	func _init():
		name = "Mercury"
		#controller = FactionManager.FascistEmpire
	
class Venus extends Location:
	func _init():
		name = "Venus"
		#controller = FactionManager.SexyAliens
		
class Earth extends Location:
	func _init():
		name = "Earth"
		#controller = FactionManager.PluckyRebels

static var AllLocations = [Mercury.new(), Venus.new(), Earth.new()]
