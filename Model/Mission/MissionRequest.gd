extends Resource
class_name MissionRequest

var origin: FactionComponent
var target: FactionComponent
var location: LocationComponent
var objective: Objective

var components: Array[MissionComponent]:
	get:
		return [origin, target, location, objective] as Array[MissionComponent]

func _init(o_fac: FactionComponent, t_fac: FactionComponent = null, loc: LocationComponent = null, objecv: Objective = null):
	origin = o_fac
	target = t_fac
	location = loc
	objective = objecv
