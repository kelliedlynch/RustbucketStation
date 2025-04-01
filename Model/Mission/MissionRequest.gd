extends MissionBase
class_name MissionRequest

func _init(o_fac: FactionComponent, t_fac: FactionComponent = null, loc: LocationComponent = null, objecv: Objective = null):
	origin = o_fac
	target = t_fac
	location = loc
	objective = objecv
