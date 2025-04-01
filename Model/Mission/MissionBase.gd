extends Resource
## Base class for Missions and MissionRequests
class_name MissionBase

var origin: FactionComponent
var target: FactionComponent
var location: LocationComponent
var objective: Objective

var components: Array[MissionComponent]:
	get:
		return [origin, target, location, objective] as Array[MissionComponent]
